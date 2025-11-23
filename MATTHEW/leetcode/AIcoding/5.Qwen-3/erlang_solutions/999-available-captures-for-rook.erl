-module(available_captures_for_rook).
-export([numRookCaptures/1]).

numRookCaptures(Board) ->
    find_rook(Board, 0, 0).

find_rook([], _, _) ->
    0;
find_rook([Row | Rest], RowIdx, ColIdx) ->
    case lists:keymember($R, 1, Row) of
        true ->
            ColIdx = lists:keyfind($R, 1, Row),
            count_captures(Row, RowIdx, ColIdx, Rest);
        false ->
            find_rook(Rest, RowIdx + 1, 0)
    end.

count_captures(_, _, _, []) ->
    0;
count_captures(Row, RowIdx, ColIdx, [OtherRow | Rest]) ->
    Left = check_left(Row, ColIdx - 1),
    Right = check_right(Row, ColIdx + 1),
    Up = check_up(Rest, RowIdx - 1, ColIdx),
    Down = check_down(Rest, RowIdx + 1, ColIdx),
    Left + Right + Up + Down.

check_left(_, -1) ->
    0;
check_left(Row, ColIdx) ->
    case lists:nth(ColIdx + 1, Row) of
        $p -> 1;
        $R -> 0;
        _ -> check_left(Row, ColIdx - 1)
    end.

check_right(_, Length) when Length >= length(Row) ->
    0;
check_right(Row, ColIdx) ->
    case lists:nth(ColIdx + 1, Row) of
        $p -> 1;
        $R -> 0;
        _ -> check_right(Row, ColIdx + 1)
    end.

check_up([], _, _) ->
    0;
check_up([Row | Rest], RowIdx, ColIdx) ->
    case lists:nth(ColIdx + 1, Row) of
        $p -> 1;
        $R -> 0;
        _ -> check_up(Rest, RowIdx - 1, ColIdx)
    end.

check_down([], _, _) ->
    0;
check_down([Row | Rest], RowIdx, ColIdx) ->
    case lists:nth(ColIdx + 1, Row) of
        $p -> 1;
        $R -> 0;
        _ -> check_down(Rest, RowIdx + 1, ColIdx)
    end.