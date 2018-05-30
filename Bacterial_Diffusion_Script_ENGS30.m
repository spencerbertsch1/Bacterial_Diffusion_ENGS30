%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ENGS30 - Spring 2018 - Dartmouth College 
%~~~~~~~~~~~~~~~~~~~
% Bacterial Diffusion in Concentration Gradient 
%
% Author: Spencer Bertsch
% Date: May 10, 2018
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%clear all variables
clear
clc
%%%%%%%%%%%%%%%%%%%%

%% User Input
disp('Enter "1" to see X, Y, and Z components of the bacteria motion plotted over time.')
disp('Enter "2" to see a three dimensional representation of the bacterial motion over time.')
disp('Enter "3" to see a three dimensional representation with a different color scheme.')

problemnumber = input('Enter a number: ');

%% Variables

% NOTE: a gradient of '0.5' means that the concentration change in that
% direction is zero. anything other than 0.5 means that there is either a
% repulsive or attractive gradient. This can be thought of as either
% glucose that would attract the bacteria or some type of acid that would
% repel it. 

% ----- Gradient ---------------------------------
x_gradient = 0.5;        %| Change the gradient in the x, y, or z direction in order to
y_gradient = 0.5;        %| increase or decrease the probability of the bacteria to travel up
z_gradient = 0.47;       %| or down a glucose gradient!
% ------------------------------------------------

%Set step size 
step = 0.1; 

%time vector
dt = 0.005; %sec 
t = 0:dt:60; %seconds 

%% Numerical Solution Euler Chromer Method 

%Create empty vectors to be filled by below code
x=zeros(1,length(t));
y=zeros(1,length(t));
z=zeros(1,length(t));

%Set starting position to (0,0,0) 
x(1)=0;
y(1)=0;
z(1)=0;

for i=2:length(t)
    if(rand(1,1)>=x_gradient) %<--- Concentration gradient in the X dimension
        x(i)=x(i-1)+step;
    else
        x(i)=x(i-1)-step;
    end
    if(rand(1,1)<=y_gradient) %<--- Concentration gradient in the Y dimension
        y(i)=y(i-1)+step;
    else
        y(i)=y(i-1)-step;
    end
    if(rand(1,1)>=z_gradient) %<--- Concentration gradient in the Z dimension
        z(i)=z(i-1)+step;
    else
        z(i)=z(i-1)-step;
    end
end %The logic in this loop was adapted from SOURCE [2] - see below. 
%% Plots

switch problemnumber  
    case 1 %represents the first case in the switch statement
%% 2D PLOTTING %%% 
figure('Position',[204    52   907   745]);
subplot(3,1,1)
plot(t,x,'r','linewidth',1)
title('X Component of Bacteria Motion')
xlabel('Time (sec)')
ylabel('X Position')
grid

subplot(3,1,2)
plot(t,y,'g','linewidth',1)
title('Y Component of Bacteria Motion')
xlabel('Time (sec)')
ylabel('Y Position')
grid

subplot(3,1,3)
plot(t,z,'b','linewidth',1)
title('Z Component of Bacteria Motion')
xlabel('Time (sec)')
ylabel('Z Position')
grid

    case 2 %second plot
%%% 3D Plotting %%%
figure('Position',[204    52   907   745]); %make initial size large
for k = 1:35:length(t)
    plot3(x(1:k),y(1:k),z(1:k),'b','linewidth',0.8)
    title([num2str(t(k)), ' Seconds']);
    axis([ -24.9823  30.4832  -24.9823  30.4832  -10.9823  60.4832 ])
    ylabel('Y Position')
    zlabel('Z Position')
    set(gca,'fontsize',20)
    grid on
    
    %%% rotating view angle #1
     campos([(-155.5363 + k/20) (-389.7880 - k/20) (314.5237 + k/60)]) 
     camtarget([5 0 30])
      
    drawnow 

end

    case 3 %third plot
        %%% different color scheme just for fun %%% 
figure('Position',[204    52   907   745]); %make initial size large
for k = 1:35:length(t)
    plot3(x(1:k),y(1:k),z(1:k),'c','linewidth',0.95)
    title([num2str(t(k)), ' Seconds']);
    axis([ -24.9823  30.4832  -24.9823  30.4832  -10.9823  60.4832 ])
    xlabel('X Position')
    ylabel('Y Position')
    zlabel('Z Position')
    set(gca,'fontsize',20)
    colormap winter
    grid on 
    set(gca,'color','black') %<---vvv UNCOMMENT to make background black
    ax = gca;
    ax.GridColor = 'white';  % [R, G, B]
    
    %%% rotating view angle #1
     campos([(-155.5363 + k/40) (-389.7880 + k/80) (314.5237 - k/60)])
     camtarget([5 0 30])
    
    drawnow 

end

end %ends switch statement

% --- SOURCES --- 
% 1. https://en.wikipedia.org/wiki/Random_walk
% 2. https://www.mathworks.com/matlabcentral/fileexchange/47451-simple-random-walk-in-three-dimensions?focused=3832075&tab=function
% 3. https://www.ncbi.nlm.nih.gov/pubmed/26745427
