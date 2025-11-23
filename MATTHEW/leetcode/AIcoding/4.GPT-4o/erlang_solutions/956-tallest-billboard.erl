-module(solution).
-export([tallest_billboard/1]).

tallest_billboard(Ribbons) ->
    Max = 1000,
    DP = lists:duplicate(2 * Max + 1, -1),
    DP ! (Max, 0) = 0,
    lists:foldl(fun(X, DP) ->
        lists:foldl(fun(Y, DP) ->
            case Y of
                -1 -> DP;
                _ -> 
                    if
                        Y + X =< 2 * Max -> 
                            set(DP, Y + X, lists:nth(Y + Max + 1, DP) + 1);
                        true -> DP
                    end
            end
        end, DP, lists:seq(-Max, Max))
    end, DP, Ribbons),
    lists:max(DP).

set(DP, Index, Value) ->
    lists:map(fun(I) -> if I =:= Index -> Value; true -> lists:nth(I + 1, DP) end end, lists:seq(0, length(DP) - 1)).