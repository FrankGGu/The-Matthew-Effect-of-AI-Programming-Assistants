-module(solution).
-export([min_flips/1]).

min_flips(S) ->
    min_flips(S, 0, 0).

min_flips([], _, Acc) ->
    Acc;
min_flips([H | T], Count, Acc) ->
    case H of
        $0 ->
            min_flips(T, Count, Acc);
        $1 ->
            min_flips(T, Count + 1, min(Acc, Count))
    end.