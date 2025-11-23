-module(solution).
-export([max_equal_product/1]).

max_equal_product(List) ->
    MaxLength = length(List),
    MaxProduct = 0,
    MaxCount = 0,
    lists:foldl(fun(X, {Prods, Count}) ->
        NewProds = lists:map(fun(P) -> P * X end, Prods),
        NewCount = lists:foldl(fun(P, Acc) -> if P =:= MaxProduct -> Acc + 1; true -> Acc end end, Count, NewProds),
        {NewProds, NewCount}
    end, {[1], 0}, List),
    MaxCount.