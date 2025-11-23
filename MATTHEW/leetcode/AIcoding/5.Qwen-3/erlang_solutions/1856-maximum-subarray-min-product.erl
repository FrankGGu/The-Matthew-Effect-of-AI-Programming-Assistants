-module(maximum_subarray_min_product).
-export([minProduct/1]).

minProduct(Nums) ->
    maxSubarrayMinProduct(Nums).

maxSubarrayMinProduct(Nums) ->
    N = length(Nums),
    Left = getLeftBounds(Nums),
    Right = getRightBounds(Nums),
    lists:foldl(fun(I, Acc) ->
                        Num = lists:nth(I+1, Nums),
                        LeftBound = lists:nth(I+1, Left),
                        RightBound = lists:nth(I+1, Right),
                        Min = Num,
                        Count = RightBound - LeftBound - 1,
                        Product = Min * Count,
                        if
                            Product > Acc -> Product;
                            true -> Acc
                        end
                end, 0, lists:seq(0, N-1)).

getLeftBounds(Nums) ->
    N = length(Nums),
    Left = lists:duplicate(N, -1),
    Stack = [],
    lists:foldl(fun(I, {Stack, Left}) ->
                        Num = lists:nth(I+1, Nums),
                        while Stack /= [] andalso lists:nth(hd(Stack)+1, Nums) >= Num do
                            [H | T] = Stack,
                            lists:setelement(H+1, Left, I),
                            {T, Left}
                        end,
                        {lists:cons(I, Stack), Left}
                end, {Stack, Left}, lists:seq(0, N-1)),
    Left.

getRightBounds(Nums) ->
    N = length(Nums),
    Right = lists:duplicate(N, N),
    Stack = [],
    lists:foldl(fun(I, {Stack, Right}) ->
                        Num = lists:nth(I+1, Nums),
                        while Stack /= [] andalso lists:nth(hd(Stack)+1, Nums) > Num do
                            [H | T] = Stack,
                            lists:setelement(H+1, Right, I),
                            {T, Right}
                        end,
                        {lists:cons(I, Stack), Right}
                end, {Stack, Right}, lists:seq(0, N-1)),
    Right.