-module(minimum_cost_of_buying_candies_with_discount).
-export([shoppingOffers/2]).

shoppingOffers(Prices, Discounts) ->
    shoppingOffers(Prices, Discounts, 0).

shoppingOffers([], _, _) ->
    0;
shoppingOffers([Price | Rest], Discounts, Index) ->
    Total = Price,
    Discounted = applyDiscounts(Index, Prices, Rest, Discounts),
    Total + Discounted.

applyDiscounts(_, _, _, []) ->
    0;
applyDiscounts(Index, [Price | Rest], Rest, [Discount | _]) ->
    case lists:member(Index, Discount) of
        true ->
            lists:sum(Rest) * (1 - (lists:nth(2, Discount) / 100));
        false ->
            0
    end;
applyDiscounts(Index, [Price | Rest], Rest, [_ | DiscountRest]) ->
    applyDiscounts(Index, [Price | Rest], Rest, DiscountRest).