-module(solution).
-export([maximumLength/1]).

maximumLength(S) ->
    N = erlang:length(S),
    MaxLen = 0,
    Map = maps:new(),
    generateSubstrings(S, N, 0, 0, Map, MaxLen).

generateSubstrings(_, _, _, _, Map, MaxLen) when MaxLen >= 3 ->
    MaxLen;
generateSubstrings(S, N, Start, End, Map, MaxLen) ->
    if
        End > N ->
            generateSubstrings(S, N, Start + 1, Start + 1, Map, MaxLen);
        true ->
            Sub = string:substr(S, Start + 1, End - Start),
            Count = maps:get(Sub, Map, 0),
            NewMap = maps:put(Sub, Count + 1, Map),
            case Count + 1 of
                3 ->
                    NewMaxLen = max(MaxLen, End - Start),
                    generateSubstrings(S, N, Start + 1, Start + 1, NewMap, NewMaxLen);
                _ ->
                    generateSubstrings(S, N, Start, End + 1, NewMap, MaxLen)
            end
    end.