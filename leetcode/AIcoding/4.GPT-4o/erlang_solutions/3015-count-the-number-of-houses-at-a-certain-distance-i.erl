-module(solution).
-export([count_houses/2]).

count_houses(Houses, distance) ->
    lists:foldl(fun(House, Acc) ->
        case lists:filter(fun(X) -> abs(X - House) == distance end, Houses) of
            [] -> Acc;
            _ -> Acc + 1
        end
    end, 0, Houses).