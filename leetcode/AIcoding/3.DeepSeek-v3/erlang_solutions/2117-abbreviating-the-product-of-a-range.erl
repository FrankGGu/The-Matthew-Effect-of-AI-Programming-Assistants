-module(solution).
-export([abbreviate_product/1]).

abbreviate_product(Left) ->
    abbreviate_product(Left, Left).

abbreviate_product(Left, Right) when Left > Right ->
    {0, 0, 0};
abbreviate_product(Left, Right) ->
    Product = lists:foldl(fun(X, Acc) -> Acc * X end, 1, lists:seq(Left, Right)),
    Count = count_trailing_zeros(Product),
    Product1 = Product div (trunc(math:pow(10, Count))),
    Len = length(integer_to_list(Product1)),
    if
        Len > 10 ->
            First5 = list_to_integer(string:substr(integer_to_list(Product1), 1, 5)),
            Last5 = Product1 rem 100000,
            {First5, Last5, Count};
        true ->
            {Product1, 0, Count}
    end.

count_trailing_zeros(N) ->
    count_trailing_zeros(N, 0).

count_trailing_zeros(N, Count) when N rem 10 == 0 ->
    count_trailing_zeros(N div 10, Count + 1);
count_trailing_zeros(_, Count) ->
    Count.