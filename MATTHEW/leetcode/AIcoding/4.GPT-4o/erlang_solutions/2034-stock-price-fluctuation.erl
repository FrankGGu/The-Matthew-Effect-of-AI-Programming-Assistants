-module(Solution).
-export([average_price/1, maximum_price_fluctuation/1]).

-record(stock, {price, timestamp}).

average_price(Prices) ->
    Total = lists:foldl(fun({Price, _}, Acc) -> Acc + Price end, 0, Prices),
    Length = length(Prices),
    Total / Length.

maximum_price_fluctuation(Prices) ->
    Sorted = lists:sort(fun({_, T1}, {_, T2}) -> T1 < T2 end, Prices),
    {Min, _} = hd(Sorted),
    {Max, _} = hd(lists:reverse(Sorted)),
    Max#stock.price - Min#stock.price.