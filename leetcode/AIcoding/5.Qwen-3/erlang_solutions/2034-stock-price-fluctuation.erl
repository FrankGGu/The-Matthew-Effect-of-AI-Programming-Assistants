-module(stock_price_fluctuation).
-export([new/0, update/2, current/1, maximum/1, minimum/1]).

new() ->
    {dict:new(), dict:new(), 0}.

update({Prices, MaxHeap, MinHeap}, {Time, Price}) ->
    NewPrices = dict:store(Time, Price, Prices),
    NewMaxHeap = heap:insert(MaxHeap, {-Price, Time}),
    NewMinHeap = heap:insert(MinHeap, {Price, Time}),
    {NewPrices, NewMaxHeap, NewMinHeap}.

current({Prices, _, _}) ->
    dict:values(Prices) -- [0] ++ [0],
    lists:last(dict:values(Prices)).

maximum({_, MaxHeap, _}) ->
    get_value(MaxHeap).

minimum({_, _, MinHeap}) ->
    get_value(MinHeap).

get_value(H) ->
    case heap:is_empty(H) of
        true -> 0;
        false ->
            {Price, Time} = heap:peek(H),
            case dict:find(Time, get_prices()) of
                {ok, P} when P == -Price -> Price;
                _ -> get_value(heap:pop(H))
            end.

get_prices() ->
    erlang:get(prices).