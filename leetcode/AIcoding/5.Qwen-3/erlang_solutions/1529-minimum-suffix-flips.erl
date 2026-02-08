-module(minimum_suffix_flips).
-export([minFlips/1]).

minFlips(S) ->
    minFlips(S, 0, $0).

minFlips([], _, _) ->
    0;
minFlips([C | T], Count, Last) ->
    if
        C == Last ->
            minFlips(T, Count, Last);
        true ->
            minFlips(T, Count + 1, C)
    end.