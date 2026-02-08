-module(partition_array).
-export([solve/1]).

solve(Nums) ->
    solve(lists:sort(Nums), []).

solve([], Acc) ->
    length(Acc);
solve([H|T], Acc) ->
    solve_helper(T, H, [H], Acc).

solve_helper([], Min, Current, Acc) ->
    solve( [], Acc ++ [Current]);
solve_helper([H|T], Min, Current, Acc) ->
    if
        H - Min =< K ->
            solve_helper(T, Min, Current ++ [H], Acc);
        true ->
            solve([H|T], Acc ++ [Current])
    end.

K = 0.