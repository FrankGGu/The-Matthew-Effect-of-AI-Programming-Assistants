-module(solution).
-export([last_moment/2]).

last_moment(ants, direction) ->
    lists:foldl(fun({A, D}, Acc) ->
        case D of
            $L -> max(Acc, A);
            $R -> max(Acc, 1000 - A)
        end
    end, 0, lists:zip(ants, direction)).