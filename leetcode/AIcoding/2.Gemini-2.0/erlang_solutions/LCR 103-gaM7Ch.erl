-module(coin_change).
-export([coin_change/2]).

coin_change(Coins, Amount) ->
    coin_change(Coins, Amount, #{}).

coin_change(Coins, 0, Cache) ->
    {ok, 0};
coin_change(Coins, Amount, Cache) when Amount < 0 ->
    {error, no_solution};
coin_change(Coins, Amount, Cache) ->
    case maps:get(Amount, Cache, undefined) of
        undefined ->
            Solutions = [coin_change(Coins, Amount - Coin, Cache) || Coin <- Coins],
            ValidSolutions = [Count || {ok, Count} <- Solutions],
            case ValidSolutions of
                [] ->
                    maps:put(Amount, {error, no_solution}, Cache),
                    {error, no_solution};
                Counts ->
                    MinCount = lists:min([Count + 1 || Count <- Counts]),
                    maps:put(Amount, {ok, MinCount}, Cache),
                    {ok, MinCount}
            end;
        {ok, Count} ->
            {ok, Count};
        {error, no_solution} ->
            {error, no_solution}
    end.