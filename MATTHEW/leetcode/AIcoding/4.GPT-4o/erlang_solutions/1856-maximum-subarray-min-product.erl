-module(solution).
-export([maxSubarrayMinProduct/1]).

maxSubarrayMinProduct(Nums) ->
    N = length(Nums),
    PrefixSum = lists:foldl(fun(X, Acc) -> [X + hd(Acc)] ++ Acc end, [0], lists:reverse(Nums)),
    MinProduct = lists:foldl(fun(Index, Acc) ->
        Min = lists:nth(Index + 1, Nums),
        Left = findLeft(Index, Nums),
        Right = findRight(Index, Nums),
        Sum = lists:nth(Right + 1, PrefixSum) - lists:nth(Left, PrefixSum),
        MaxProduct = (Sum * Min) rem (10#0000#0007),
        max(Acc, MaxProduct)
    end, 0, lists:seq(0, N - 1)),
    MinProduct.

findLeft(Index, Nums) ->
    findLeft(Index, Nums, Index).

findLeft(Index, Nums, Current) when Current > 0 ->
    if
        lists:nth(Current + 1, Nums) < lists:nth(Index + 1, Nums) ->
            findLeft(Index, Nums, Current - 1);
        true -> Current
    end;
findLeft(_, _, 0) -> 0.

findRight(Index, Nums) ->
    findRight(Index, Nums, Index).

findRight(Index, Nums, Current) when Current < length(Nums) - 1 ->
    if
        lists:nth(Current + 1, Nums) < lists:nth(Index + 1, Nums) ->
            findRight(Index, Nums, Current + 1);
        true -> Current
    end;
findRight(_, _, Current) -> Current.