-module(longest_substring).
-export([length_of_longest_substring/1]).

length_of_longest_substring(S) ->
    length_of_longest_substring(S, 0, 0, []).

length_of_longest_substring([], MaxLen, _, _) ->
    MaxLen;
length_of_longest_substring([H|T], MaxLen, Start, Seen) ->
    case lists:member(H, Seen) of
        true ->
            Index = find_index(H, Seen, 1),
            NewStart = Start + Index,
            NewSeen = lists:sublist(Seen, Index + 1, length(Seen) - Index),
            NewSeen2 = NewSeen ++ [H],
            NewLen = length(NewSeen2),
            NewMaxLen = max(MaxLen, NewLen),
            length_of_longest_substring(T, NewMaxLen, NewStart, NewSeen2);
        false ->
            NewSeen = Seen ++ [H],
            NewLen = length(NewSeen),
            NewMaxLen = max(MaxLen, NewLen),
            length_of_longest_substring(T, NewMaxLen, Start, NewSeen)
    end.

find_index(Element, List, Index) ->
    case lists:nth(Index, List) of
        Element ->
            Index;
        _ ->
            find_index(Element, List, Index + 1)
    end.