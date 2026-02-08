-module(solution).
-export([countBinarySubstrings/1]).

countBinarySubstrings(S) ->
    countBinarySubstrings(S, 0, 0, 0).

countBinarySubstrings([], _, _, Acc) ->
    Acc;
countBinarySubstrings([C | T], PrevCount, CurrentCount, Acc) ->
    if
        C == hd(T) ->
            countBinarySubstrings(T, PrevCount, CurrentCount + 1, Acc);
        true ->
            countBinarySubstrings(T, CurrentCount, 1, Acc + min(PrevCount, CurrentCount))
    end.