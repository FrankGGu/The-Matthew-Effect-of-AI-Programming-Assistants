-module(minimum_cost_for_cutting_cake).
-export([cost/2]).

cost(Cuts, Prices) ->
    lists:sort(Cuts),
    cost(Cuts, Prices, 0).

cost([], _, Cost) ->
    Cost;
cost([Cut | Rest], Prices, Cost) ->
    Price = price(Cut, Prices),
    cost(Rest, Prices, Cost + Price).

price(_, []) ->
    0;
price(Cut, [{C, P} | _]) when C == Cut ->
    P;
price(Cut, [_ | Rest]) ->
    price(Cut, Rest).