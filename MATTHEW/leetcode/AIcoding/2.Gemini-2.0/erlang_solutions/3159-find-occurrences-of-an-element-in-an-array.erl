-module(solution).
-export([solve/2]).

solve(Nums, Target) ->
    solve(Nums, Target, 0, []).

solve([], _, _, Acc) ->
    lists:reverse(Acc);
solve([H | T], Target, Index, Acc) ->
    if
        H =:= Target ->
            solve(T, Target, Index + 1, [Index | Acc]);
        true ->
            solve(T, Target, Index + 1, Acc)
    end.