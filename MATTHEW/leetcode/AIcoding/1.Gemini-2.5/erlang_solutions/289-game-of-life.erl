-module(solution).
-export([gameOfLife/1]).

gameOfLife(Board) ->
    M = length(Board),
    N = length(hd(Board)),

    get_cell(R, C, CurrentBoard, MaxR, MaxC) when R >= 0, R < MaxR, C >= 0, C < MaxC ->
        lists:nth(C + 1, lists:nth(R + 1, CurrentBoard));
    get_cell(_, _, _, _, _) ->
        0.

    count_live_neighbors(R, C, CurrentBoard, MaxR, MaxC) ->
        Neighbors = [
            {R-1, C-1}, {R-1, C}, {R-1, C+1},
            {R,   C-1},           {R,   C+1},
            {R+1, C-1}, {R+1, C}, {R+1, C+1}
        ],
        lists:foldl(fun({NR, NC}, Acc) ->
            CellValue = get_cell(NR, NC, CurrentBoard, MaxR, MaxC),
            case CellValue of
                1 -> Acc + 1;
                2 -> Acc + 1;
                _ -> Acc
            end
        end, 0, Neighbors).

    EncodedBoard = lists:mapi(fun(R_idx, Row) ->
        lists:mapi(fun(C_idx, Cell) ->
            LiveNeighbors = count_live_neighbors(R_idx, C_idx, Board, M, N),
            case Cell of
                1 ->
                    case LiveNeighbors of
                        LNC when LNC < 2 -> 2;
                        LNC when LNC == 2; LNC == 3 -> 1;
                        LNC when LNC > 3 -> 2
                    end;
                0 ->
                    case LiveNeighbors of
                        3 -> 3;
                        _ -> 0
                    end
            end
        end, Row)
    end, Board),

    FinalBoard = lists:map(fun(Row) ->
        lists:map(fun(Cell) ->
            case Cell of
                2 -> 0;
                3 -> 1;
                _ -> Cell
            end
        end, Row)
    end, EncodedBoard),

    FinalBoard.