-module(shortest_matching_substring).
-export([shortestSubsequence/2]).

shortestSubsequence(S, T) ->
    N = length(S),
    M = length(T),
    MinLen = M + 1,
    {Result, _} = lists:foldl(fun(I, {Min, Start}) ->
        case findMatch(S, T, I, Min, Start) of
            {ok, NewStart, NewLen} when NewLen < Min ->
                {NewLen, NewStart};
            _ ->
                {Min, Start}
        end
    end, {MinLen, 0}, lists:seq(0, N - 1)),
    if
        Result =:= M + 1 -> "";
        true -> substring(S, Result, Result + 1)
    end.

findMatch(S, T, Start, MinLen, _) when Start >= length(S) -> {error, 0, 0};
findMatch(S, T, Start, MinLen, CurrentStart) ->
    TIndex = 0,
    SIndex = Start,
    Matched = matchFrom(S, T, SIndex, TIndex),
    if
        Matched == length(T) ->
            Len = Matched + Start - CurrentStart,
            if
                Len < MinLen -> {ok, Start, Len};
                true -> {error, 0, 0}
            end;
        true -> {error, 0, 0}
    end.

matchFrom(_, _, SIndex, TIndex) when SIndex >= length(S) andalso TIndex < length(T) -> TIndex;
matchFrom(S, T, SIndex, TIndex) when TIndex >= length(T) -> SIndex;
matchFrom(S, T, SIndex, TIndex) ->
    if
        element(SIndex + 1, S) == element(TIndex + 1, T) ->
            matchFrom(S, T, SIndex + 1, TIndex + 1);
        true ->
            matchFrom(S, T, SIndex + 1, TIndex)
    end.

substring(S, Start, End) ->
    lists:sublist(S, Start + 1, End - Start).