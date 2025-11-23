-module(battleships_in_a_board).
-export([count_battleships/1]).

count_battleships(Board) ->
    count_battleships(Board, 0, 0, 0).

count_battleships([], _, _, Count) ->
    Count;
count_battlesships([Row | Rest], RowIndex, ColIndex, Count) when ColIndex >= length(Row) ->
    count_battleships(Rest, RowIndex + 1, 0, Count);
count_battleships([Row | Rest], RowIndex, ColIndex, Count) ->
    Current = lists:nth(ColIndex + 1, Row),
    if
        Current == $X ->
            IsTop = RowIndex == 0 orelse lists:nth(ColIndex + 1, lists:nth(RowIndex - 1, Rest)) /= $X,
            IsLeft = ColIndex == 0 orelse lists:nth(ColIndex, Row) /= $X,
            if
                IsTop andalso IsLeft ->
                    count_battleships(Rest, RowIndex, ColIndex + 1, Count + 1);
                true ->
                    count_battleships(Rest, RowIndex, ColIndex + 1, Count)
            end;
        true ->
            count_battleships(Rest, RowIndex, ColIndex + 1, Count)
    end.