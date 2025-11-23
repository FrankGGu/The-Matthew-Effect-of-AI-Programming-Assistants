-module(solution).
-export([minimum_replacements/1]).

minimum_replacements(List) ->
    Sorted = lists:sort(List),
    Count = minimum_replacements_helper(List, Sorted, 0),
    Count.

minimum_replacements_helper([], _, Count) ->
    Count;
minimum_replacements_helper([H | T], Sorted, Count) ->
    case lists:member(H, Sorted) of
        true ->
            minimum_replacements_helper(T, Sorted, Count);
        false ->
            NewCount = Count + 1,
            minimum_replacements_helper(T, Sorted, NewCount)
    end.