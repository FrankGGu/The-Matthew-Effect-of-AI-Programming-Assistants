-module(battleships).
-export([countBattleships/1]).

countBattleships(Board) ->
    countBattleshipsHelper(Board, 0, 0, 0).

countBattleshipsHelper([], _, _, Count) ->
    Count;
countBattleshipsHelper([Row | Rest], RowIndex, Width, Count) ->
    case RowIndex == 0 of
        true ->
            countBattleshipsHelper(Rest, RowIndex + 1, length(Row), countRow(Row, 0, 0));
        false ->
            countBattleshipsHelper(Rest, RowIndex + 1, Width, Count + countRow(Row, 0, 0, RowIndex, Width, Rest));
        _ ->
            Count
    end.

countRow([], _, Count) ->
    Count;
countRow([Elem | Rest], ColIndex, Count) ->
    case Elem of
        $X ->
            countRow(Rest, ColIndex + 1, Count + 1);
        _ ->
            countRow(Rest, ColIndex + 1, Count)
    end.

countRow([], _, Count, _, _, _) ->
    Count;
countRow([Elem | Rest], ColIndex, Count, RowIndex, Width, [NextRow | _]) ->
    case Elem of
        $X ->
            case ColIndex > 0 andalso lists:nth(ColIndex, NextRow) == $X of
                true ->
                    countRow(Rest, ColIndex + 1, Count, RowIndex, Width, [NextRow]);
                false ->
                    countRow(Rest, ColIndex + 1, Count + 1, RowIndex, Width, [NextRow])
            end;
        _ ->
            countRow(Rest, ColIndex + 1, Count, RowIndex, Width, [NextRow])
    end.

countRow([Elem | Rest], ColIndex, Count, RowIndex, Width, []) ->
    case Elem of
        $X ->
            countRow(Rest, ColIndex + 1, Count + 1, RowIndex, Width, []);
        _ ->
            countRow(Rest, ColIndex + 1, Count, RowIndex, Width, [])
    end.