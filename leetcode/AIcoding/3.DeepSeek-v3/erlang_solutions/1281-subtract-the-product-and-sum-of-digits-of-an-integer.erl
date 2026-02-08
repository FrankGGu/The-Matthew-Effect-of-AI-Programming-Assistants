-spec subtract_product_and_sum(N :: integer()) -> integer().
subtract_product_and_sum(N) ->
    Digits = digits(N),
    Product = lists:foldl(fun(X, Acc) -> X * Acc end, 1, Digits),
    Sum = lists:sum(Digits),
    Product - Sum.

digits(0) -> [];
digits(N) when N > 0 -> digits(N, []).

digits(0, Acc) -> Acc;
digits(N, Acc) -> digits(N div 10, [N rem 10 | Acc]).