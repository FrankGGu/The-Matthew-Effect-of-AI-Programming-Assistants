-module(solution).
-export([min_moves/1]).

min_moves(Arr) ->
    Total = lists:sum(Arr),
    N = length(Arr),
    Half = N div 2,
    T = Total - (N - Half) * 1,
    Max = lists:max(Arr),
    MinMoves = max(0, Max * Half - T),
    MinMoves.