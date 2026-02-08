-module(solution).
-export([occurrences_after_searches/2]).

occurrences_after_searches(Queries, Pattern) ->
    lists:map(fun(Q) -> count_occurrences(Q, Pattern) end, Queries).

count_occurrences(S, P) ->
    count_occurrences(S, P, 0, 0).

count_occurrences([], _, _, Acc) ->
    Acc;
count_occurrences([H|T], P, Pos, Acc) ->
    case is_pattern_at_position(S, P, Pos) of
        true ->
            count_occurrences(T, P, Pos + 1, Acc + 1);
        false ->
            count_occurrences(T, P, Pos + 1, Acc)
    end.

is_pattern_at_position(S, P, Pos) ->
    LenP = length(P),
    LenS = length(S),
    Pos + LenP <= LenS andalso lists:sublist(S, Pos + 1, LenP) == P.