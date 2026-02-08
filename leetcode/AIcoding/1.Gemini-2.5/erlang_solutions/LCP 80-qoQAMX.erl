-module(solution).
-export([solve/1]).

solve(S) ->
    N = length(S),
    find_k(S, N, 1).

find_k(S, N, LenT) when LenT =< N ->
    if
        N rem LenT == 0 ->
            K = N div LenT,
            Sub = lists:sublist(S, 1, LenT),
            IsMatch = check_repetition(S, Sub),
            if
                IsMatch ->
                    K;
                true ->
                    find_k(S, N, LenT + 1)
            end;
        true ->
            find_k(S, N, LenT + 1)
    end;
find_k(_S, _N, _LenT) ->
    1.

check_repetition(S, Sub) ->
    check_repetition_loop(S, Sub, Sub).

check_repetition_loop([], _CurrentSub, _OriginalSub) ->
    true;
check_repetition_loop([H_S | T_S], [H_Sub | T_Sub], OriginalSub) ->
    if
        H_S == H_Sub ->
            NextSub = if T_Sub == [] -> OriginalSub; true -> T_Sub end,
            check_repetition_loop(T_S, NextSub, OriginalSub);
        true ->
            false
    end.