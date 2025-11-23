-module(sum_good_subsequences).
-export([solve/1]).

solve(Nums) ->
    solve(Nums, 0, 1).

solve([], Acc, Mod) ->
    (Acc - 1 + Mod) rem Mod;
solve([H|T], Acc, Mod) ->
    solve(T, (Acc + H) rem Mod, Mod).