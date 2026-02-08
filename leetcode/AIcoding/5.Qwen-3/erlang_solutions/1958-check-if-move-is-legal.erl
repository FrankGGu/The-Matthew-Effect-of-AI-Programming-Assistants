-module(solution).
-export([is_legal/2]).

is_legal(Board, Move) ->
    [R1, C1] = lists:split(1, Move),
    [R2, C2] = lists:split(1, lists:nthtail(1, Move)),
    R1Val = lists:nth(R1, Board),
    R2Val = lists:nth(R2, Board),
    (lists:nth(C1, R1Val) == $B) andalso (lists:nth(C2, R2Val) == $.) andalso (abs(R1 - R2) == 1) andalso (abs(C1 - C2) == 1).