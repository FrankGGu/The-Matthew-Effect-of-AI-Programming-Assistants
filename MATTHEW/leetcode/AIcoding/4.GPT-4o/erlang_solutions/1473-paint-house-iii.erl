-module(solution).
-export([min_cost/3]).

min_cost(Houses, M, K) ->
    N = length(Houses),
    dp(0, 0, 0, M, K, Houses, []).

dp(Index, LastColor, LastCount, M, K, Houses, Memo) when Index == length(Houses) ->
    if LastCount == K -> 
        0;
    true -> 
        1e9 
    end;
dp(Index, LastColor, LastCount, M, K, Houses, Memo) ->
    case lists:member({Index, LastColor, LastCount}, Memo) of
        true -> 
            1e9;
        false ->
            case lists:nth(Index + 1, Houses) of
                0 -> 
                    lists:foldl(fun(Color, MinCost) ->
                        Cost = dp(Index + 1, Color, if Color == LastColor -> LastCount + 1; true -> 1 end, M, K, Houses, Memo),
                        min(MinCost, Cost)
                    end, 1e9, lists:seq(1, M));
                Color -> 
                    Cost = dp(Index + 1, Color, if Color == LastColor -> LastCount + 1; true -> 1 end, M, K, Houses, Memo),
                    Cost
            end
    end.

min(X, Y) when X < Y -> X;
min(X, Y) -> Y.