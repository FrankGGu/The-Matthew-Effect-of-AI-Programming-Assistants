-module(solution).
-export([changingKeys/2]).

changingKeys(Keys, K) ->
    lists:foldl(fun(From, Acc) ->
        lists:foldl(fun(To, Acc2) ->
            case From == To of
                true -> Acc2;
                false -> Acc2 + 1
            end
        end, Acc, Keys)
    end, 0, Keys) div 2.