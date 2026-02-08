-module(minimum_number_of_coins_to_be_added).
-export([coin_change/2]).

coin_change(Coins, Amount) ->
    coin_change(Coins, Amount, #{}).

coin_change(_, 0, _) ->
    0;
coin_change([], _, _) ->
    -1;
coin_change(Coins, Amount, Memo) ->
    case maps:find(Amount, Memo) of
        {ok, Val} ->
            Val;
        error ->
            Res = lists:foldl(fun(Coin, Acc) ->
                if
                    Coin > Amount ->
                        Acc;
                    true ->
                        case coin_change(Coins, Amount - Coin, Memo) of
                            -1 ->
                                Acc;
                            Val ->
                                min(Acc, Val + 1)
                        end
                end
            end, infinity, Coins),
            case Res of
                infinity ->
                    maps:put(Amount, -1, Memo);
                _ ->
                    maps:put(Amount, Res, Memo)
            end
    end.