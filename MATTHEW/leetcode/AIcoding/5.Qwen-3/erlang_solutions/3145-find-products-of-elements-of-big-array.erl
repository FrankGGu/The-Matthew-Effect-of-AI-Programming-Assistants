-module(solution).
-export([array_product/1]).

array_product(Nums) ->
    N = length(Nums),
    Left = array_product_left(Nums, 0, N, []),
    Right = array_product_right(Nums, N-1, -1, []),
    lists:zipwith(fun(L, R) -> L * R end, Left, Right).

array_product_left([], _, _, Acc) ->
    lists:reverse(Acc);
array_product_left([H|T], Index, N, Acc) when Index < N ->
    Product = case Acc of
        [] -> 1;
        [Prev|_] -> Prev * H
    end,
    array_product_left(T, Index + 1, N, [Product | Acc]);
array_product_left(_, _, _, Acc) ->
    lists:reverse(Acc).

array_product_right([], _, _, Acc) ->
    lists:reverse(Acc);
array_product_right([H|T], Index, Step, Acc) when Index >= 0 ->
    Product = case Acc of
        [] -> 1;
        [Prev|_] -> Prev * H
    end,
    array_product_right(T, Index + Step, Step, [Product | Acc]);
array_product_right(_, _, _, Acc) ->
    lists:reverse(Acc).