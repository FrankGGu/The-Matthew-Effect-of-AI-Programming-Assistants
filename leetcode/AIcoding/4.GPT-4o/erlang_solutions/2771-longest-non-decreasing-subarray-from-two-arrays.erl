-module(solution).
-export([findLength/2]).

findLength(A, B) ->
    N = length(A),
    findLengthHelper(A, B, N, 0, 0).

findLengthHelper(A, B, N, MaxLen, CurrentLen) ->
    case N of
        0 -> MaxLen;
        _ ->
            NewCurrentLen1 = if
                CurrentLen =< 0 orelse (hd(A) =< hd(B)) -> CurrentLen + 1;
                true -> 1
            end,
            NewCurrentLen2 = if
                CurrentLen =< 0 orelse (hd(B) =< hd(A)) -> CurrentLen + 1;
                true -> 1
            end,
            MaxLen1 = max(MaxLen, NewCurrentLen1),
            MaxLen2 = max(MaxLen, NewCurrentLen2),
            findLengthHelper(tl(A), tl(B), N - 1, max(MaxLen1, MaxLen2), CurrentLen)
    end.