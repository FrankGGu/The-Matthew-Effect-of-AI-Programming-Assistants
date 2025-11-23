-module(solution).
-export([init/3, randPoint/1]).

-record(circle, {radius :: float(), x_center :: float(), y_center :: float()}).

-define(RAND_DENOM, 1000000000). % A large integer for random float precision

init(Radius, X_center, Y_center) ->
    random:seed(erlang:now()),
    #circle{radius = Radius, x_center = X_center, y_center = Y_center}.

randPoint(Circle) ->
    #circle{radius = R, x_center = XC, y_center = YC} = Circle,

    RandFloat0To1Exclusive = fun() -> (random:uniform(?RAND_DENOM) - 1) / ?RAND_DENOM.0 end,

    RandFloat0To1Inclusive = fun() -> (random:uniform(?RAND_DENOM + 1) - 1) / ?RAND_DENOM.0 end,

    Theta = 2.0 * math:pi() * RandFloat0To1Exclusive(),

    R_uniform = R * math:sqrt(RandFloat0To1Inclusive()),

    Dx = R_uniform * math:cos(Theta),
    Dy = R_uniform * math:sin(Theta),

    X = XC + Dx,
    Y = YC + Dy,

    [X, Y].