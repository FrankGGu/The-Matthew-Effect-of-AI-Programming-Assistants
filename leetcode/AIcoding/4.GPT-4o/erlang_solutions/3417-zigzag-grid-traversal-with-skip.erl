-module(solution).
-export([zigzag_traversal/2]).

zigzag_traversal(Grid, Skip) ->
    Rows = length(Grid),
    Columns = length(hd(Grid)),
    zigzag_traversal_helper(Grid, Skip, 0, 0, Rows, Columns, []).

zigzag_traversal_helper(_, _, Row, _, Rows, _, Acc) when Row >= Rows ->
    lists:reverse(Acc);
zigzag_traversal_helper(Grid, Skip, Row, Col, Rows, Columns, Acc) ->
    case (Row rem 2) of
        0 -> % left to right
            case Col < Columns of
                true -> 
                    zigzag_traversal_helper(Grid, Skip, Row, Col + 1, Rows, Columns, [lists:nth(Col + 1, lists:nth(Row + 1, Grid)) | Acc]);
                false -> 
                    zigzag_traversal_helper(Grid, Skip, Row + 1, 0, Rows, Columns, Acc)
            end;
        1 -> % right to left
            case Col >= 0 of
                true -> 
                    zigzag_traversal_helper(Grid, Skip, Row, Col - 1, Rows, Columns, [lists:nth(Col + 1, lists:nth(Row + 1, Grid)) | Acc]);
                false -> 
                    zigzag_traversal_helper(Grid, Skip, Row + 1, Columns - 1, Rows, Columns, Acc)
            end
    end.