-module(longest_substring_without_repeating_characters).
-export([length_of_longest_substring/1]).

length_of_longest_substring(S) ->
    length_of_longest_substring(S, [], 0, 0).

length_of_longest_substring([], _, MaxLen, CurrentLen) ->
    max(MaxLen, CurrentLen);
length_of_longest_substring([H|T], Seen, MaxLen, CurrentLen) ->
    case lists:member(H, Seen) of
        true ->
            Pos = lists:index(H, Seen),
            NewSeen = lists:sublist(Seen, Pos + 1, length(Seen) - Pos),
            length_of_longest_substring(T, [H|NewSeen], max(MaxLen, CurrentLen), length(NewSeen) + 1);
        false ->
            length_of_longest_substring(T, [H|Seen], MaxLen, CurrentLen + 1)
    end.

max(A, B) ->
    if A > B -> A;
    true -> B
    end.