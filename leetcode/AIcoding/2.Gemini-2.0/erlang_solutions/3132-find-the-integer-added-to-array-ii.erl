-module(solution).
-export([solve/1]).

solve(Nums) ->
    solve(Nums, 0).

solve([], Acc) ->
    Acc;
solve([H|T], Acc) ->
    solve(T, Acc + H).