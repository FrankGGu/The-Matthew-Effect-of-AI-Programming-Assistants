-module(shopping_offers).
-export([shopping_offers/2]).

shopping_offers(Cost, Promotions) ->
    shopping_offers(Cost, Promisions, dict:new()).

shopping_offers(_, [], _) ->
    0;
shopping_offers(Cost, [Promotion | Rest], Dict) ->
    {Items, Discount} = Promotion,
    Key = lists:sort(Items),
    case dict:is_key(Key, Dict) of
        true ->
            shopping_offers(Cost, Rest, Dict);
        false ->
            NewDict = dict:store(Key, Discount, Dict),
            Price = calculate_price(Cost, Items, Discount),
            OtherPrice = shopping_offers(Cost, Rest, Dict),
            min(Price, OtherPrice)
    end.

calculate_price(Cost, Items, Discount) ->
    Total = lists:foldl(fun(Item, Acc) -> Acc + Cost ! Item end, 0, Items),
    Total - Discount.