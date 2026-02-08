-module(solution).
-export([separate_squares/1]).

separate_squares(N) ->
    List = lists:seq(1, N),
    Squares = lists:filter(fun(X) -> is_square(X) end, List),
    NonSquares = lists:filter(fun(X) -> not is_square(X) end, List),
    Squares ++ NonSquares.

is_square(X) ->
    S = round(math:sqrt(X)),
    S * S =:= X.