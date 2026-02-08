-module(checkout).
-export([checkout/0, scan/2, get_total/1]).

checkout() ->
    {dict:new(), []}.

scan({Items, Discounts}, Item) ->
    NewItems = dict:update_counter(Item, 1, Items),
    {NewItems, Discounts}.

get_total({Items, Discounts}) ->
    lists:sum(
        lists:map(
            fun({Item, Count}) ->
                Price = get_price(Item),
                Discount = get_discount(Item, Discounts),
                apply_discount(Price, Count, Discount)
            end,
            dict:to_list(Items)
        )
    ).

get_price("A") -> 50;
get_price("B") -> 30;
get_price("C") -> 20;
get_price("D") -> 15.

get_discount(Item, Discounts) ->
    case lists:keyfind(Item, 1, Discounts) of
        false -> {0, 0};
        {_, SpecialCount, SpecialPrice} -> {SpecialCount, SpecialPrice}
    end.

apply_discount(Price, Count, {0, 0}) ->
    Price * Count;
apply_discount(Price, Count, {SpecialCount, SpecialPrice}) ->
    Specials = Count div SpecialCount,
    Remainder = Count rem SpecialCount,
    Specials * SpecialPrice + Remainder * Price.