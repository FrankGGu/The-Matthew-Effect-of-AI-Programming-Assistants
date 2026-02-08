-module(solution).
-export([shopping_offers/3]).

shopping_offers(Price, Special, Needs) ->
    MinCost = shopping_offers_helper(Price, Special, Needs),
    MinCost.

shopping_offers_helper(_, [], Needs) ->
    total_price(Needs);
shopping_offers_helper(Price, [Offer | Rest], Needs) ->
    NewNeeds = apply_offer(Needs, Offer),
    CostWithOffer = if
        NewNeeds =:= undefined -> infinity;
        true -> shopping_offers_helper(Price, Rest, NewNeeds)
    end,
    CostWithoutOffer = shopping_offers_helper(Price, Rest, Needs),
    min(CostWithOffer + offer_price(Offer), CostWithoutOffer).

total_price(Needs) ->
    lists:sum(lists:map(fun({Item, Count}) -> Item * Count end, lists:zip(Price, Needs))).

apply_offer(Needs, Offer) ->
    OfferCount = tl(Offer),
    NewNeeds = lists:map(fun({N, C}) -> N - C end, lists:zip(Needs, OfferCount)),
    if
        lists:any(fun(N) -> N < 0 end, NewNeeds) -> undefined;
        true -> NewNeeds
    end.

offer_price(Offer) ->
    hd(Offer).