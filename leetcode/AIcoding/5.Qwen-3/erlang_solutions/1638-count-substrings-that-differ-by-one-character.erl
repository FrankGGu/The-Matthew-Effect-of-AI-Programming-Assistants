-module(solution).
-export([count_substrings/2]).

count_substrings(S, T) ->
    count_substrings(S, T, 0, 0, 0).

count_substrings([], _, _, _, Acc) ->
    Acc;
count_substrings(_, [], _, _, Acc) ->
    Acc;
count_substrings(S, T, I, J, Acc) ->
    case S of
        [C | _] when C /= hd(T) ->
            count_substrings(S, T, I + 1, J + 1, Acc + 1);
        _ ->
            count_substrings(S, T, I + 1, J + 1, Acc)
    end.