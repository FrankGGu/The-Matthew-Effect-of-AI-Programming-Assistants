-module(solution).
-export([sum_floored_pairs/1]).

sum_floored_pairs(A) ->
    Max = lists:max(A),
    Count = array:new([{size, Max + 1}, {default, 0}]),
    lists:foreach(fun(X) -> array:set(X, array:get(X, Count) + 1, Count) end, A),
    Sum = 0,
    lists:foldl(fun(I, Acc) ->
        lists:foldl(fun(J, Acc2) ->
            K = (I * J) - 1,
            if
                K >= Max -> Acc2 + (array:get(I, Count) * array:get(J, Count));
                true -> Acc2 + (array:get(I, Count) * (array:subarray(1, K, Count)))
            end
        end, Acc, lists:seq(1, Max))
    end, Sum, lists:seq(1, Max)).

array:subarray(Start, End, Arr) ->
    array:to_list(array:split(End, array:split(Start - 1, Arr))).