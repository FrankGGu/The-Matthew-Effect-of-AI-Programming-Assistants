-module(solution).
-export([max_non_intersecting_substrings/1]).

max_non_intersecting_substrings(S) ->
    max_non_intersecting_substrings(S, 0, [], []).

max_non_intersecting_substrings([], _, _, Acc) ->
    lists:reverse(Acc);
max_non_intersecting_substrings([C | T], Start, Current, Acc) ->
    case lists:member(C, Current) of
        true ->
            % Found a duplicate, split here
            NewAcc = [lists:sublist(S, Start + 1, length(Current))] ++ Acc,
            max_non_intersecting_substrings(T, 0, [C], NewAcc);
        false ->
            max_non_intersecting_substrings(T, Start, [C | Current], Acc)
    end.