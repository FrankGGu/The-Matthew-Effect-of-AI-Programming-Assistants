-module(zero_array_transformation_iii).
-export([maxOperations/2]).

maxOperations(Nums, k) ->
    N = length(Nums),
    Count = lists:foldl(fun(X, Acc) -> maps:update_with(X rem k, fun(V) -> V + 1 end, 1, Acc) end, maps:new(), Nums),
    Max = maps:fold(fun(_, V, Acc) -> max(V, Acc) end, 0, Count),
    case Max of
        0 -> 0;
        _ -> (lists:sum(maps:values(Count)) - Max) div (k - 1)
    end.