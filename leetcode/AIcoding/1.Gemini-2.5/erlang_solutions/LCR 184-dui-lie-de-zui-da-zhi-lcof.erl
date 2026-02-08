-module(solution).
-export([new/0, set_item_price/3, add_customer/2, scan_item/3, checkout_next_customer/1]).

new() ->
    {maps:new(), maps:new(), queue:new()}.

set_item_price({Prices, CustomerBaskets, CustomerQueue}, ItemId, Price) ->
    {maps:put(ItemId, Price, Prices), CustomerBaskets, CustomerQueue}.

add_customer({Prices, CustomerBaskets, CustomerQueue}, CustomerId) ->
    NewCustomerBaskets = maps:put(CustomerId, maps:new(), CustomerBaskets),
    NewCustomerQueue = queue:in(CustomerId, CustomerQueue),
    {Prices, NewCustomerBaskets, NewCustomerQueue}.

scan_item({Prices, CustomerBaskets, CustomerQueue}, CustomerId, ItemId) ->
    CustomerBasket = maps:get(CustomerId, CustomerBaskets, maps:new()),
    CurrentCount = maps:get(ItemId, CustomerBasket, 0),
    NewCustomerBasket = maps:put(ItemId, CurrentCount + 1, CustomerBasket),
    NewCustomerBaskets = maps:put(CustomerId, NewCustomerBasket, CustomerBaskets),
    {Prices, NewCustomerBaskets, CustomerQueue}.

checkout_next_customer({Prices, CustomerBaskets, CustomerQueue}) ->
    case queue:out(CustomerQueue) of
        {{value, CustomerId}, RemainingQueue} ->
            CustomerBasket = maps:get(CustomerId, CustomerBaskets),
            TotalCost = calculate_cost(CustomerBasket, Prices),
            NewCustomerBaskets = maps:remove(CustomerId, CustomerBaskets),
            {TotalCost, {Prices, NewCustomerBaskets, RemainingQueue}};
        {empty, _} ->
            error(no_customers_in_queue)
    end.

calculate_cost(CustomerBasket, Prices) ->
    maps:fold(fun(ItemId, Count, Acc) ->
                      Price = maps:get(ItemId, Prices, 0),
                      Acc + (Price * Count)
              end, 0, CustomerBasket).