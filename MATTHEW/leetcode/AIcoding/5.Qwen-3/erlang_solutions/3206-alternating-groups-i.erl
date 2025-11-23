-module(alternating_groups_i).
-export([numberOfAlternatingGroups/1]).

numberOfAlternatingGroups(S) ->
    numberOfAlternatingGroups(S, 0, 0).

numberOfAlternatingGroups([], _Index, Count) ->
    Count;
numberOfAlternatingGroups([_], _Index, Count) ->
    Count;
numberOfAlternatingGroups([A, B | Rest], Index, Count) ->
    if
        A /= B ->
            numberOfAlternatingGroups([B | Rest], Index + 1, Count + 1);
        true ->
            numberOfAlternatingGroups([B | Rest], Index + 1, Count)
    end.