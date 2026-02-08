-module(solution).
-export([solve/1]).

solve(Nums) ->
    solve(Nums, 0, 0).

solve([], _, Acc) ->
    Acc;
solve([H | T], Prev, Acc) ->
    if
        H >= Prev ->
            solve(T, H, Acc);
        true ->
            solve(T, H, Acc + 1)
    end.