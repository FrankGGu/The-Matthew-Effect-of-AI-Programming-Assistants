-module(length_of_longest_substring).
-export([length_of_longest_substring/1]).

length_of_longest_substring(S) ->
    length_of_longest_substring(S, 0, 0, dict:new(), 0).

length_of_longest_substring([], _Start, _MaxLen, _Dict, _Pos) ->
    _MaxLen;
length_of_longest_substring([C | T], Start, MaxLen, Dict, Pos) ->
    case dict:is_key(C, Dict) of
        true ->
            PrevPos = dict:fetch(C, Dict),
            if
                PrevPos >= Start ->
                    NewStart = PrevPos + 1;
                true ->
                    NewStart = Start
            end,
            NewDict = dict:store(C, Pos, Dict),
            length_of_longest_substring(T, NewStart, max(MaxLen, Pos - NewStart + 1), NewDict, Pos + 1);
        false ->
            NewDict = dict:store(C, Pos, Dict),
            length_of_longest_substring(T, Start, max(MaxLen, Pos - Start + 1), NewDict, Pos + 1)
    end.