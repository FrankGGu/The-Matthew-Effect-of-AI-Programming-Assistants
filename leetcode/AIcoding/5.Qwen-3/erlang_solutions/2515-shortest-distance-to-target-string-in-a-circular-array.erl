-module(solution).
-export([shortest_distance/2]).

shortest_distance(Str, Target) ->
    N = length(Str),
    lists:foldl(fun(I, Acc) ->
        case lists:nth(I+1, Str) of
            Target -> min(Acc, min(I, N - I));
            _ -> Acc
        end
    end, N, lists:seq(0, N-1)).