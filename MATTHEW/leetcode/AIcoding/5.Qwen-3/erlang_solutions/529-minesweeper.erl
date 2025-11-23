-module(minesweeper).
-export([update_board/2]).

update_board(Board, {X, Y}) ->
    Rows = length(Board),
    Cols = length(hd(Board)),
    if
        X < 0 orelse X >= Rows orelse Y < 0 orelse Y >= Cols -> Board;
        true ->
            case lists:nth(X+1, Board, []) of
                [] -> Board;
                Row ->
                    case lists:nth(Y+1, Row, $.) of
                        $M -> 
                            NewRow = lists:sublist(Row, Y) ++ [$X] ++ lists:nthtail(Y+1, Row),
                            lists:sublist(Board, X) ++ [NewRow] ++ lists:nthtail(X+1, Board);
                        _ ->
                            if
                                lists:nth(X+1, Board, []) == [] -> Board;
                                true ->
                                    Count = count_mines(Board, X, Y),
                                    if
                                        Count > 0 ->
                                            NewRow = lists:sublist(Row, Y) ++ [integer_to_list(Count)] ++ lists:nthtail(Y+1, Row),
                                            lists:sublist(Board, X) ++ [NewRow] ++ lists:nthtail(X+1, Board);
                                        true ->
                                            NewRow = lists:sublist(Row, Y) ++ [$ ] ++ lists:nthtail(Y+1, Row),
                                            UpdatedBoard = lists:sublist(Board, X) ++ [NewRow] ++ lists:nthtail(X+1, Board),
                                            dfs(UpdatedBoard, X, Y)
                                    end
                            end
                    end
            end
    end.

count_mines(Board, X, Y) ->
    Count = 0,
    Directions = [{-1, -1}, {-1, 0}, {-1, 1}, {0, -1}, {0, 1}, {1, -1}, {1, 0}, {1, 1}],
    lists:foldl(fun({DX, DY}, Acc) ->
        NX = X + DX,
        NY = Y + DY,
        if
            NX < 0 orelse NX >= length(Board) orelse NY < 0 orelse NY >= length(hd(Board)) -> Acc;
            true ->
                case lists:nth(NX+1, Board, []) of
                    [] -> Acc;
                    Row ->
                        case lists:nth(NY+1, Row, $.) of
                            $M -> Acc + 1;
                            _ -> Acc
                        end
                end
        end
    end, Count, Directions).

dfs(Board, X, Y) ->
    Directions = [{-1, -1}, {-1, 0}, {-1, 1}, {0, -1}, {0, 1}, {1, -1}, {1, 0}, {1, 1}],
    lists:foldl(fun({DX, DY}, AccBoard) ->
        NX = X + DX,
        NY = Y + DY,
        if
            NX < 0 orelse NX >= length(AccBoard) orelse NY < 0 orelse NY >= length(hd(AccBoard)) -> AccBoard;
            true ->
                case lists:nth(NX+1, AccBoard, []) of
                    [] -> AccBoard;
                    Row ->
                        case lists:nth(NY+1, Row, $.) of
                            $X -> AccBoard;
                            _ ->
                                if
                                    lists:nth(NX+1, AccBoard, []) == [] -> AccBoard;
                                    true ->
                                        Count = count_mines(AccBoard, NX, NY),
                                        if
                                            Count > 0 ->
                                                NewRow = lists:sublist(Row, NY) ++ [integer_to_list(Count)] ++ lists:nthtail(NY+1, Row),
                                                lists:sublist(AccBoard, NX) ++ [NewRow] ++ lists:nthtail(NX+1, AccBoard);
                                            true ->
                                                NewRow = lists:sublist(Row, NY) ++ [$ ] ++ lists:nthtail(NY+1, Row),
                                                UpdatedBoard = lists:sublist(AccBoard, NX) ++ [NewRow] ++ lists:nthtail(NX+1, AccBoard),
                                                dfs(UpdatedBoard, NX, NY)
                                        end
                                end
                        end
                end
        end
    end, Board, Directions).