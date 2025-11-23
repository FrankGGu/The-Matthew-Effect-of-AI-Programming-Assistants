-module(solution).
-export([coinChange/2]).

coinChange(Coins, Amount) ->
    coinChange(Coins, Amount, []).

coinChange(_, 0, Memo) -> 
    0;
coinChange([], Amount, _) ->
    infinity;
coinChange(Coins, Amount, Memo) ->
    case lists:keyfind(Amount, 1, Memo) of
        false ->
            MinCoins = lists:min(
                [coinChange(Coins, Amount - Coin, [{Amount, Result} | Memo]) + 1 || Coin <- Coins, Coin =< Amount]
            ),
            case MinCoins of
                infinity -> 
                    infinity;
                _ -> 
                    {Amount, MinCoins} 
            end;
        {Amount, Result} -> 
            Result
    end.