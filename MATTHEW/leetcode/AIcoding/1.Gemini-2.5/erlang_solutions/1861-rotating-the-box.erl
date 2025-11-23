-module(solution).
-export([rotateTheBox/1]).

rotateTheBox(Box) ->
    RotatedBox = rotate(Box),
    lists:map(fun(Row) -> gravity_helper(Row) end, RotatedBox).

rotate(Box) ->
    R = length(Box),
    C = length(hd(Box)),
    [ [lists:nth(ColIdx, lists:nth(R - RowIdx + 1, Box)) || RowIdx <- lists:seq(1, R)] || ColIdx <- lists:seq(1, C) ].

gravity_helper(Row) ->
    gravity_helper_rec(Row, []).

gravity_helper_rec([], Acc) ->
    lists:flatten(Acc);
gravity_helper_rec(Row, Acc) ->
    {BeforeObstacle, AfterObstacle} = lists:splitwith(fun(C) -> C =/= $# end, Row),
    case AfterObstacle of
        [] ->
            process_segment(BeforeObstacle, Acc);
        [$#|Rest] ->
            NewAcc = process_segment(BeforeObstacle, [[$#]|Acc]),
            gravity_helper_rec(Rest, NewAcc)
    end.

process_segment(Segment, Acc) ->
    NumStones = lists:sum([1 || C <- Segment, C == $*]),
    NumDots = length(Segment) - NumStones,
    [lists:duplicate(NumStones, $*), lists:duplicate(NumDots, $.) | Acc].