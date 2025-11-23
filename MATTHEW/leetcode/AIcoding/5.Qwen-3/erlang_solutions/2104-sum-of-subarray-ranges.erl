-module(solutions).
-export([sum_subarray_ranges/1]).

sum_subarray_ranges(Nums) ->
    Sum = 0,
    N = length(Nums),
    lists:foldl(fun(I, Acc) ->
        lists:foldl(fun(J, Acc2) ->
            if I < J ->
                Min = lists:min(lists:sublist(Nums, I+1, J-I)),
                Max = lists:max(lists:sublist(Nums, I+1, J-I)),
                Acc2 + (Max - Min);
            true ->
                Acc2
            end
        end, Acc, lists:seq(I+1, N-1))
    end, Sum, lists:seq(0, N-1)).