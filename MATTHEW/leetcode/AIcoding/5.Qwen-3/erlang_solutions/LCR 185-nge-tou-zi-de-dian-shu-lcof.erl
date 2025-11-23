-module(probability).
-export([probability/2]).

probability(Nums, target) ->
    Count = lists:foldl(fun(X, Acc) -> if X == target -> Acc + 1; true -> Acc end end, 0, Nums),
    Length = length(Nums),
    Count / Length.