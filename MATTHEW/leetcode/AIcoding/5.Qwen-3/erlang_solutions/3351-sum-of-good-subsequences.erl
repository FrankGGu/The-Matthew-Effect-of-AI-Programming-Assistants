-module(solve).
-export([solve/1]).

solve(S) ->
    solve(S, 0, 0, 0).

solve([], _, _, Sum) ->
    Sum;
solve([H | T], Index, CurrentSum, TotalSum) ->
    solve(T, Index + 1, CurrentSum + H, TotalSum + H),
    solve(T, Index + 1, CurrentSum, TotalSum).