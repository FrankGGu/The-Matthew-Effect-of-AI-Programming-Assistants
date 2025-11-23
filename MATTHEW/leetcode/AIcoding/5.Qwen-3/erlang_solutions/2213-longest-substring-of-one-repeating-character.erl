-module(longest_repeating_substring).
-export([length_of_longest_substring/1]).

length_of_longest_substring(S) ->
    length_of_longest_substring(S, 0, 0, 0, $0).

length_of_longest_substring([], _, Max, _, _) ->
    Max;
length_of_longest_substring([C | T], Index, Max, Count, PrevChar) ->
    if
        C == PrevChar ->
            NewCount = Count + 1,
            NewMax = max(Max, NewCount),
            length_of_longest_substring(T, Index + 1, NewMax, NewCount, C);
        true ->
            length_of_longest_substring(T, Index + 1, Max, 1, C)
    end.