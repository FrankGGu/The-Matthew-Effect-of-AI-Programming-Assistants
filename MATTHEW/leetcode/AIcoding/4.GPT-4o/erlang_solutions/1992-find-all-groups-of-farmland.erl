-module(solution).
-export([find_farmland/1]).

find_farmland(Farm) ->
    Rows = length(Farm),
    Cols = length(hd(Farm)),
    find_farmland_helper(Farm, Rows, Cols, 0, 0, []).

find_farmland_helper(_, Rows, _, Row, Col, Acc) when Row >= Rows -> 
    lists:reverse(Acc);
find_farmland_helper(Farm, Rows, Cols, Row, Col, Acc) when Col >= Cols -> 
    find_farmland_helper(Farm, Rows, Cols, Row + 1, 0, Acc);
find_farmland_helper(Farm, Rows, Cols, Row, Col, Acc) ->
    case lists:nth(Col + 1, lists:nth(Row + 1, Farm)) of
        1 -> 
            {StartRow, StartCol} = {Row, Col},
            {EndRow, EndCol} = find_end(Farm, Rows, Cols, Row, Col),
            NewAcc = [[StartRow, StartCol, EndRow, EndCol] | Acc],
            find_farmland_helper(Farm, Rows, Cols, StartRow, EndCol + 1, NewAcc);
        _ -> 
            find_farmland_helper(Farm, Rows, Cols, Row, Col + 1, Acc)
    end.

find_end(Farm, Rows, Cols, Row, Col) ->
    case lists:nth(Col + 1, lists:nth(Row + 1, Farm)) of
        1 -> 
            case Col + 1 < Cols of
                true -> find_end(Farm, Rows, Cols, Row, Col + 1);
                false -> 
                    case Row + 1 < Rows of
                        true -> find_end(Farm, Rows, Cols, Row + 1, 0);
                        false -> {Row, Col}
                    end
            end;
        _ -> {Row, Col}
    end.