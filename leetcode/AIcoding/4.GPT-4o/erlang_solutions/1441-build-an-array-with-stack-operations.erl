-module(solution).
-export([buildArray/1]).

buildArray(N) ->
    lists:foldl(fun(X, Acc) ->
        case Acc of
            [] -> [1];
            _ -> 
                Last = lists:last(Acc),
                if 
                    Last + 1 =:= X -> Acc ++ [X];
                    Last + 1 < X -> Acc ++ [Last + 1, X];
                    true -> Acc
                end
        end
    end, [], lists:seq(1, N).