-module(longest_substring).
-export([length_of_longest_substring/1]).

length_of_longest_substring(S) ->
    length_of_longest_substring(S, 0, 0, #{}).

length_of_longest_substring([], _Start, MaxLen, _Chars) ->
    MaxLen;
length_of_longest_substring([C | T], Start, MaxLen, Chars) ->
    case maps:find(C, Chars) of
        {ok, Pos} when Pos >= Start ->
            NewStart = Pos + 1,
            NewMax = max(MaxLen, Start - NewStart + 1),
            length_of_longest_substring(T, NewStart, NewMax, maps:put(C, Start, Chars));
        _ ->
            NewMax = max(MaxLen, Start - 0 + 1),
            length_of_longest_substring(T, Start, NewMax, maps:put(C, Start, Chars))
    end.