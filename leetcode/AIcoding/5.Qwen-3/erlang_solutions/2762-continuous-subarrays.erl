-module(continuous_subarrays).
-export([subarray_count/1]).

subarray_count(Nums) ->
    Count = 0,
    N = length(Nums),
    lists:foldl(fun(I, Acc) ->
        lists:foldl(fun(J, Acc2) ->
            A = lists:sublist(Nums, I+1, J-I),
            Sum = lists:sum(A),
            Max = lists:max(A),
            Min = lists:min(A),
            if
                Sum == Max + Min ->
                    Acc2 + 1;
                true ->
                    Acc2
            end
        end, Acc, lists:seq(I+1, N-1))
    end, Count, lists:seq(0, N-1)).