-module(solution).
-export([numRookCaptures/1]).

numRookCaptures(Board) ->
    RookPos = find_rook(Board),
    RookPos =:= undefined -> 0;
    Captures = count_captures(RookPos, Board, 0),
    Captures.

find_rook(Board) ->
    lists:foldl(fun({Row, Col}, Acc) ->
        case lists:nth(Col, Row) of
            <<"R">> -> {Row, Col};
            _ -> Acc
        end
    end, undefined, lists:zip(Board, lists:seq(1, 8))).

count_captures({R, C}, Board, Count) ->
    CountUp = count_direction({R, C}, {0, -1}, Board),
    CountDown = count_direction({R, C}, {0, 1}, Board),
    CountLeft = count_direction({R, C}, {-1, 0}, Board),
    CountRight = count_direction({R, C}, {1, 0}, Board),
    Count + CountUp + CountDown + CountLeft + CountRight.

count_direction({R, C}, {Dr, Dc}, Board) ->
    case lists:drop(R, lists:nth(C, Board)) of
        [] -> 0;
        Row ->
            case lists:nth(1, Row) of
                <<"p">> -> 1;
                <<"B">> -> 0;
                _ -> count_direction({R + Dr, C + Dc}, {Dr, Dc}, Board)
            end
    end.