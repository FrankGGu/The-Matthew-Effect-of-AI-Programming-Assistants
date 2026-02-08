-module(min_insertions_to_balance_parentheses).
-export([minAddToMakeValid/1]).

minAddToMakeValid(S) ->
    minAddToMakeValid(S, 0, 0).

minAddToMakeValid([], _, Insertions) ->
    Insertions;
minAddToMakeValid([$($ | T], Open, Insertions) ->
    minAddToMakeValid(T, Open + 1, Insertions);
minAddToMakeValid([$)] | T], Open, Insertions) ->
    if
        Open > 0 ->
            minAddToMakeValid(T, Open - 1, Insertions);
        true ->
            minAddToMakeValid(T, Open, Insertions + 1)
    end.