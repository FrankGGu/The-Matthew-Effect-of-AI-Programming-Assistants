-module(shopping_offers).
-export([shopping_offers/3]).

shopping_offers(Price, Special, Needs) ->
    MinCost = lists:sum([lists:nth(I, Price) * lists:nth(I, Needs) || I <- lists:seq(1, length(Price))]),
    shopping_offers(Price, Special, Needs, MinCost).

shopping_offers(Price, Special, Needs, MinCost) ->
    case can_apply_offer(Special, Needs) of
        [] -> MinCost;
        ValidOffers ->
            NewMinCost = lists:foldl(
                fun(Offer, Acc) ->
                    NewNeeds = apply_offer(Offer, Needs),
                    Cost = lists:nth(length(Offer), Offer) + shopping_offers(Price, Special, NewNeeds, Acc),
                    min(Cost, Acc)
                end,
                MinCost,
                ValidOffers
            ),
            NewMinCost
    end.

can_apply_offer([], _) -> [];
can_apply_offer([Offer|Rest], Needs) ->
    case lists:all(fun({I, N}) -> lists:nth(I, Offer) =< N end, 
                   lists:zip(lists:seq(1, length(Needs)), Needs)) of
        true -> [Offer | can_apply_offer(Rest, Needs)];
        false -> can_apply_offer(Rest, Needs)
    end.

apply_offer(Offer, Needs) ->
    [lists:nth(I, Needs) - lists:nth(I, Offer) || I <- lists:seq(1, length(Needs))].