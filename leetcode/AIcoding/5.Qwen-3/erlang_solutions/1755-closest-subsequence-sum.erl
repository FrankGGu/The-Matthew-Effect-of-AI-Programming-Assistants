-module(closest_subsequence_sum).
-export([min_subsequence_sum/2]).

min_subsequence_sum(Nums, Target) ->
    lists:foldl(fun(N, Acc) -> 
        [N | Acc] ++ lists:map(fun(X) -> X + N end, Acc)
    end, [], Nums),
    lists:foldl(fun(Sum, {Min, Closest}) ->
        if
            abs(Sum - Target) < abs(Closest - Target) -> {Sum, Sum};
            true -> {Min, Closest}
        end
    end, {0, 0}, lists:usort(lists:flatten([[] | lists:foldl(fun(N, Acc) -> 
        [N | Acc] ++ lists:map(fun(X) -> X + N end, Acc)
    end, [], Nums)]))).

min_subsequence_sum(Nums) ->
    min_subsequence_sum(Nums, 0).