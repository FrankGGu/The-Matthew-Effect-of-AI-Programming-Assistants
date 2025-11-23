-module(solution).
-export([min_coins/1]).

min_coins(Coins) ->
    lists:foldl(fun(X, Acc) -> 
        case Acc of 
            {Count, Value} when Value >= 0 -> {Count + 1, Value - X}; 
            _ -> {Count, Value} 
        end 
    end, {0, 0}, Coins).