-module(solution).
-export([getMaxLen/1]).

getMaxLen(List) ->
    getMaxLen(List, 0, 0, 0).

getMaxLen([], PosCount, NegCount, MaxLen) ->
    MaxLen;
getMaxLen([H | T], PosCount, NegCount, MaxLen) ->
    case H of
        0 ->
            getMaxLen(T, 0, 0, MaxLen);
        _ when H > 0 ->
            getMaxLen(T, PosCount + 1, NegCount, max(MaxLen, PosCount + 1));
        _ ->
            getMaxLen(T, NegCount, PosCount + 1, max(MaxLen, NegCount + 1))
    end.