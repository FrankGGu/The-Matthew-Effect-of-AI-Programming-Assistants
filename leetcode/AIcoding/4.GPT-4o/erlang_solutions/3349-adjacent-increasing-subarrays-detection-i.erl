-module(solution).
-export([adjacent_increasing_subarrays/1]).

adjacent_increasing_subarrays(List) ->
    lists:foldl(fun(X, Acc) ->
        case Acc of
            [] -> [{X, X}];
            [{PrevStart, PrevEnd} | Rest] ->
                if
                    X > PrevEnd ->
                        [{PrevStart, X} | Rest];
                    true ->
                        [{PrevStart, PrevEnd} | Rest]
                end
        end
    end, [], List).