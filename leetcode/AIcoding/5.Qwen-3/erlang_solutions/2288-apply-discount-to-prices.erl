-module(solution).
-export([discount_prices/1]).

discount_prices(Prices) ->
    discount_prices(Prices, []).

discount_prices([], Acc) ->
    lists:reverse(Acc);
discount_prices([Price | Rest], Acc) ->
    [Discounted | _] = string:split(Price, " "),
    DiscountedNum = list_to_integer(Discounted),
    DiscountedPrice = integer_to_list(DiscountedNum * 95 div 100),
    NewPrice = string:join([DiscountedPrice | string:split(Price, " ", all)], " "),
    discount_prices(Rest, [NewPrice | Acc]).