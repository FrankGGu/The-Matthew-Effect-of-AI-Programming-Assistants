-module(solution).
-export([traffic_intersection/1]).

traffic_intersection(Roads) ->
    lists:foldl(fun({A, B}, Acc) ->
        case lists:keyfind(A, 1, Acc) of
            false -> [{A, B} | Acc];
            {A, OldB} -> lists:keyreplace(A, 1, Acc, {A, OldB + B})
        end
    end, [], Roads).