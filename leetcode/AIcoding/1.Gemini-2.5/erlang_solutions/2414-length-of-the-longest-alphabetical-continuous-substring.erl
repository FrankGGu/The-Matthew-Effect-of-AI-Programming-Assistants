-module(solution).
-export([longest_continuous_substring/1]).

longest_continuous_substring(S) ->
    case S of
        [] -> 0;
        [_] -> 1;
        [H|T] -> solve_recursive(T, H, 1, 1)
    end.

solve_recursive([], _Prev, MaxLen, _CurrentLen) ->
    MaxLen;
solve_recursive([H|T], Prev, MaxLen, CurrentLen) ->
    if
        H == Prev + 1 ->
            NewCurrentLen = CurrentLen + 1,
            solve_recursive(T, H, max(MaxLen, NewCurrentLen), NewCurrentLen);
        true ->
            solve_recursive(T, H, MaxLen, 1)
    end.