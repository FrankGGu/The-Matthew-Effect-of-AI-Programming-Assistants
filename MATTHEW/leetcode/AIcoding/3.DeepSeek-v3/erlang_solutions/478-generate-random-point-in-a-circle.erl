-module(solution).

-export([init/3, rand_point/1]).

-record(state, {radius, x_center, y_center}).

init(Radius, X_center, Y_center) ->
    {ok, #state{radius=Radius, x_center=X_center, y_center=Y_center}}.

rand_point(State) ->
    Radius = State#state.radius,
    X_center = State#state.x_center,
    Y_center = State#state.y_center,
    Theta = 2 * math:pi() * rand:uniform(),
    R = Radius * math:sqrt(rand:uniform()),
    X = X_center + R * math:cos(Theta),
    Y = Y_center + R * math:sin(Theta),
    [X, Y].