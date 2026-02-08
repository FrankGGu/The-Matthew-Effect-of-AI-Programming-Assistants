-module(product_of_last_k).
-export([new/0, add/2, product/2]).

new() ->
    {[], 1}.

add({List, Acc}, Num) ->
    NewAcc = Acc * Num,
    {lists:reverse([Num | lists:reverse(List)]), NewAcc}.

product({List, _}, K) ->
    case length(List) >= K of
        true ->
            Product = lists:foldl(fun(X, Acc) -> Acc * X end, 1, lists:sublist(List, length(List) - K + 1, K));
        false ->
            0
    end.