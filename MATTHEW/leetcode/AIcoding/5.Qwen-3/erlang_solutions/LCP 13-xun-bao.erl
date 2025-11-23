-module(treasure).
-export([compute/1]).

compute(Board) ->
    Rows = length(Board),
    Cols = length(hd(Board)),
    find_treasure(Board, 0, 0, Rows, Cols, 0).

find_treasure(_, _, _, _, _, Acc) when Acc == 2 -> Acc;
find_treasure(Board, R, C, Rows, Cols, Acc) ->
    case R of
        R when R >= Rows -> find_treasure(Board, 0, C + 1, Rows, Cols, Acc);
        _ ->
            case C of
                C when C >= Cols -> find_treasure(Board, R + 1, 0, Rows, Cols, Acc);
                _ ->
                    Value = lists:nth(R + 1, Board),
                    Cell = lists:nth(C + 1, Value),
                    case Cell of
                        $S -> find_treasure(Board, R, C + 1, Rows, Cols, Acc + 1);
                        _ -> find_treasure(Board, R, C + 1, Rows, Cols, Acc)
                    end
            end
    end.