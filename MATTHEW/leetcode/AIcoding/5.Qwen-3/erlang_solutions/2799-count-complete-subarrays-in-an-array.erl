-module(solution).
-export([countCompleteSubarrays/1]).

countCompleteSubarrays(Nums) ->
    Unique = lists:usort(Nums),
    TotalUnique = length(Unique),
    Count = 0,
    N = length(Nums),
    lists:foldl(fun(I, Acc) ->
        Sub = lists:sublist(Nums, I, N - I + 1),
        lists:foldl(fun(J, Acc2) ->
            Sub2 = lists:sublist(Sub, J, length(Sub) - J + 1),
            if
                length(lists:usort(Sub2)) == TotalUnique ->
                    Acc2 + 1;
                true ->
                    Acc2
            end
        end, Acc, lists:seq(1, length(Sub)))
    end, 0, lists:seq(1, N)).