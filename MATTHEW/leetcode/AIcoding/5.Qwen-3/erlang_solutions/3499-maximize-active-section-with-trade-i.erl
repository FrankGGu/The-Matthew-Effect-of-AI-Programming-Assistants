-module(maximize_active_section_with_trade_i).
-export([maxActive/1]).

maxActive(Prices) ->
    maxActive(Prices, 0, 0, 0).

maxActive([], Buy, Sell, Max) ->
    Max;
maxActive([Price | Rest], Buy, Sell, Max) ->
    case Buy of
        0 ->
            maxActive(Rest, Price, Sell, Max);
        _ ->
            if
                Price > Sell ->
                    NewSell = Price,
                    NewMax = max(Max, NewSell - Buy),
                    maxActive(Rest, Buy, NewSell, NewMax);
                true ->
                    maxActive(Rest, Buy, Sell, Max)
            end
    end.