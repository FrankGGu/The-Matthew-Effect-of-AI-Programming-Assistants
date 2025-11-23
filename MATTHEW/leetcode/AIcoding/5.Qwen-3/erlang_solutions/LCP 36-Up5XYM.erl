-module(solution).
-export([maxNumberOfGroups/1]).

maxNumberOfGroups(Nums) ->
    Count = lists:foldl(fun(N, Acc) -> dict:update_counter(N, 1, Acc) end, dict:new(), Nums),
    Sorted = lists:sort(dict:to_list(Count)),
    Max = length(Sorted),
    solve(Sorted, 0, 0).

solve([], _, Acc) ->
    Acc;
solve([{_Val, C} | T], I, Acc) ->
    if
        C > 0 ->
            NewAcc = Acc + (C div (I + 1)),
            solve(T, I + 1, NewAcc);
        true ->
            solve(T, I, Acc)
    end.