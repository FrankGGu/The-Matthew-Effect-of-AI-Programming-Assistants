-module(number_of_ways_to_buy_pens_and_pencils).
-export([buy_pens_pencils/2]).

buy_pens_pencils(Coins, Price) ->
    buy_pens_pencils(Coins, Price, 0).

buy_pens_pencils(Coins, Price, Count) when Price > 0 ->
    case Coins of
        [] -> Count;
        [Coin | Rest] ->
            if
                Coin =< Price ->
                    NewCount = Count + 1,
                    buy_pens_pencils(Rest, Price - Coin, NewCount);
                true ->
                    buy_pens_pencils(Rest, Price, Count)
            end
    end;
buy_pens_pencils(_, _, Count) ->
    Count.