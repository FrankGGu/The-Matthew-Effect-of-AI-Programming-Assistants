-module(solution).
-export([minimum_operations/1]).

minimum_operations(Leaves) ->
    {N, _} = {length(Leaves), Leaves},
    DP = array:new([{size, N}, {default, {0, 0, 0}}]),
    DP1 = array:set(0, {if hd(Leaves) == $r -> 0; true -> 1 end, 999999, 999999}, DP),
    DP2 = lists:foldl(fun(I, Acc) ->
        {A, B, C} = array:get(I - 1, Acc),
        Current = lists:nth(I + 1, Leaves),
        NewA = A + if Current == $r -> 0; true -> 1 end,
        NewB = min(A, B) + if Current == $y -> 0; true -> 1 end,
        NewC = min(B, C) + if Current == $r -> 0; true -> 1 end,
        array:set(I, {NewA, NewB, NewC}, Acc)
    end, DP1, lists:seq(1, N - 1)),
    {_, _, Ans} = array:get(N - 1, DP2),
    Ans.