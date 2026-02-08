-module(solution).
-export([maxStrength/1]).

maxStrength(List) ->
    case lists:filter(fun(X) -> X > 0 end, List) of
        [] -> lists:foldl(fun(X, Acc) -> Acc * X end, 1, lists:filter(fun(X) -> X < 0 end, List));
        Positives -> lists:foldl(fun(X, Acc) -> Acc * X end, 1, Positives) * 
                      lists:foldl(fun(X, Acc) -> Acc * X end, 1, lists:filter(fun(X) -> X < 0 end, Positives));
    end.