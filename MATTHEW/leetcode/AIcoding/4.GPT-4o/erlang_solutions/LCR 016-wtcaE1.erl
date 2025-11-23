-module(solution).
-export([length_of_longest_substring/1]).

length_of_longest_substring(Str) ->
    length_of_longest_substring(Str, 0, dict:new(), 0).

length_of_longest_substring([], MaxLength, _, MaxLength) -> MaxLength;
length_of_longest_substring([H | T], CurrentLength, Map, MaxLength) ->
    case dict:find(H, Map) of
        error ->
            NewMap = dict:store(H, CurrentLength, Map),
            length_of_longest_substring(T, CurrentLength + 1, NewMap, max(MaxLength, CurrentLength + 1));
        {ok, Index} ->
            NewMap = dict:store(H, CurrentLength, Map),
            NewIndex = Index + 1,
            NewLength = CurrentLength - NewIndex + 1,
            NewMap2 = dict:filter(fun(_, V) -> V >= NewIndex end, NewMap),
            length_of_longest_substring(T, NewLength, NewMap2, MaxLength)
    end.