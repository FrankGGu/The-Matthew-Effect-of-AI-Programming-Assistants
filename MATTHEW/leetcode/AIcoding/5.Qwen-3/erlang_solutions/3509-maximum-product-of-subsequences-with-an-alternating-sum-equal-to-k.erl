-module(max_product).
-export([maxProduct/2]).

maxProduct(Nums, K) ->
    maxProduct(Nums, K, 0, 0, 1, 0, 0).

maxProduct([], _, _, _, _, Acc, _) -> Acc;
maxProduct([N | Rest], K, Index, Sum, Product, Max, Count) ->
    NewSum = Sum + (if Count rem 2 == 0 -> N; true -> -N end),
    if
        NewSum == K ->
            maxProduct(Rest, K, Index + 1, NewSum, Product * N, max(Max, Product * N), Count + 1);
        true ->
            maxProduct(Rest, K, Index + 1, Sum, Product, Max, Count)
    end.