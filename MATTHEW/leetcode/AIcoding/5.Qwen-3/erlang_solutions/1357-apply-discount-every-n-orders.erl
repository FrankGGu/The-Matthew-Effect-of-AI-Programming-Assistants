-module(discount).
-export([apply_discount/2]).

apply_discount(Orders, N) ->
    apply_discount(Orders, N, 1, []).

apply_discount([], _, _, Acc) ->
    lists:reverse(Acc);
apply_discount([Order | Rest], N, Count, Acc) ->
    Discount = if
        Count rem N == 0 -> Order * 0.9;
        true -> Order
    end,
    apply_discount(Rest, N, Count + 1, [Discount | Acc]).