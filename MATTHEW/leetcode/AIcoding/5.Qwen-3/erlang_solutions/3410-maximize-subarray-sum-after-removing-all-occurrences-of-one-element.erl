-module(solution).
-export([maximum_subarray_sum/1]).

maximum_subarray_sum(Nums) ->
    N = length(Nums),
    Max = 0,
    lists:foldl(fun(I, Acc) ->
        lists:foldl(fun(J, Acc2) ->
            if I == J -> Acc2;
               true ->
                    Sub = lists:sublist(Nums, 1, I - 1) ++ lists:sublist(Nums, I + 1, N - I),
                    Sum = lists:sum(Sub),
                    if Sum > Acc2 -> Sum;
                       true -> Acc2
                    end
            end
        end, Max, lists:seq(1, N))
    end, Max, lists:seq(1, N)).