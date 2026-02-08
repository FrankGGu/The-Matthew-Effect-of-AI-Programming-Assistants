-module(solution).
-export([coin_change/1]).

coin_change(Coins) ->
    coin_change(Coins, 0, 0, []).

coin_change(_, _, _, Acc) when Acc =:= [] ->
    -1;
coin_change(Coins, Target, Index, Acc) ->
    case lists:keyfind(Target, 1, Acc) of
        {Target, Steps} ->
            Steps;
        false ->
            case Target of
                0 ->
                    0;
                _ ->
                    MinSteps = lists:foldl(fun(Coin, AccMin) ->
                        if
                            Coin > Target ->
                                AccMin;
                            true ->
                                case coin_change(Coins, Target - Coin, 0, Acc) of
                                    -1 ->
                                        AccMin;
                                    Steps ->
                                        min(AccMin, Steps + 1)
                                end
                        end
                    end, 1000000, Coins),
                    case MinSteps of
                        1000000 ->
                            -1;
                        _ ->
                            coin_change(Coins, Target, Index + 1, [{Target, MinSteps} | Acc])
                    end
            end
    end.