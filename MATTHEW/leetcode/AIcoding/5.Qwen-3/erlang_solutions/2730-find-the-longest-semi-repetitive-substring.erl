-module(solution).
-export([length_of_longest_substring/1]).

length_of_longest_substring(S) ->
    length_of_longest_substring(S, 0, 0, 0, 0).

length_of_longest_substring([], _, _, Max, _) ->
    Max;
length_of_longest_substring([C | T], Start, Last, Max, Count) ->
    if
        Count == 0 ->
            length_of_longest_substring(T, Start, C, Max + 1, 1);
        C == Last ->
            length_of_longest_substring(T, Start, C, Max + 1, 1);
        true ->
            length_of_longest_substring(T, Start + 1, C, Max + 1, 1)
    end.