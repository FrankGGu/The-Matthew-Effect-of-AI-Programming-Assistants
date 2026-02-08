-module(solution).
-export([min_coins/2]).

min_coins(Fruits, Coins) ->
    lists:foldl(fun({Fruit, Count}, Acc) ->
        case lists:foldl(fun(Coin, Acc1) ->
                if
                    Coin >= Count -> 
                        min(Acc1, (Count div Coin) + (if Count rem Coin > 0 -> 1; true -> 0 end));
                    true -> 
                        Acc1
                end
            end, Acc, Coins) of
            Acc2 when Acc2 =< Acc -> Acc2;
            _ -> Acc
        end, infinity, Fruits).