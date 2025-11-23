-module(solution).
-export([solution_init_/3, solution_rand_point/0]).

%% Initialize the Solution with the radius and center position.
-spec solution_init_(float(), float(), float()) -> any().
solution_init_(Radius, X_center, Y_center) ->
    %% Store the radius and the center coordinates.
    {radius, Radius, center, {X_center, Y_center}}.

%% Generate a random point within the circle.
-spec solution_rand_point() -> [float()].
solution_rand_point() ->
    %% Generate a random point using polar coordinates (radius, angle)
    %% and convert it to Cartesian coordinates (x, y).
    {radius, X_center, Y_center} = ?STATE,
    %% Random angle between 0 and 2*pi
    Angle = random:uniform() * 2 * math:pi(),
    %% Random radius between 0 and the circle's radius
    R = math:sqrt(random:uniform()) * radius,
    %% Convert polar to Cartesian coordinates
    X = X_center + R * math:cos(Angle),
    Y = Y_center + R * math:sin(Angle),
    [X, Y].

%% Your functions will be called as such:
%% solution_init_(Radius, X_center, Y_center),
%% Param_1 = solution_rand_point(),
