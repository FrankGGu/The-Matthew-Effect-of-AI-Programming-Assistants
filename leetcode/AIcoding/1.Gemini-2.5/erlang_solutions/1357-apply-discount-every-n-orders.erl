-module(cashier).
-export([new/4, getBill/3]).

-record(cashier_state, {
    n :: integer(),
    discount :: integer(),
    products_map :: map(),
    order_count :: integer()
}).

new(N, Discount, ProductIds, ProductPrices) ->
    ProductsMap = lists:zip(ProductIds, ProductPrices),
    #cashier_state{
        n = N,
        discount = Discount,
        products_map = maps:from_list(ProductsMap),
        order_count = 0
    }.

getBill(State = #cashier_state{n = N, discount = Discount, products_map = ProductsMap, order_count = CurrentOrderCount}, ProductsList, AmountsList) ->
    NewOrderCount = CurrentOrderCount + 1,

    TotalCost = calculate_base_cost(ProductsList, AmountsList, ProductsMap, 0),

    FinalCost = 
        if 
            NewOrderCount rem N == 0 ->
                TotalCost * (100 - Discount) / 100;
            true ->
                TotalCost
        end,

    NewState = State#cashier_state{order_count = NewOrderCount},
    {NewState, FinalCost}.

calculate_base_cost([], [], _ProductsMap, Acc) -> Acc;
calculate_base_cost([ProductId | RestProducts], [Amount | RestAmounts], ProductsMap, Acc) ->
    Price = maps:get(ProductId, ProductsMap),
    calculate_base_cost(RestProducts, RestAmounts, ProductsMap, Acc + (Price * Amount)).