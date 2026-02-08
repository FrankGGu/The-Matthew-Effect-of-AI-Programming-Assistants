-module(maximum_deletions_on_a_string).
-export([max_deletions/1]).

max_deletions(S) ->
    max_deletions(S, 0, 0).

max_deletions([], _, _) ->
    0;
max_deletions([H|T], Count, Last) ->
    if
        H == Last ->
            max_deletions(T, Count + 1, H);
        true ->
            max_deletions(T, Count, H)
    end.