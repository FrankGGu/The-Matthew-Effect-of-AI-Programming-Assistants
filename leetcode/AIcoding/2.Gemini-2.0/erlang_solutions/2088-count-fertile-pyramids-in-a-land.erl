-module(fertile_pyramids).
-export([countFertilePyramids/1]).

countFertilePyramids(Grid) ->
    Rows = length(Grid),
    Cols = length(hd(Grid)),
    count(Grid, Rows, Cols, 0, 0, 0, 0).

count(Grid, Rows, Cols, Row, Col, Count, InvertedCount) ->
    if Row >= Rows then
        Count + InvertedCount
    else
        NewCount = case Grid of
            [] -> Count;
            _ ->
                if Col >= Cols then
                    count(Grid, Rows, Cols, Row + 1, 0, Count, InvertedCount)
                else
                    Fertile = count_pyramids(Grid, Rows, Cols, Row, Col),
                    InvertedFertile = count_inverted_pyramids(Grid, Rows, Cols, Row, Col),
                    count(Grid, Rows, Cols, Row, Col + 1, Count + Fertile, InvertedCount + InvertedFertile)
                end
        end,
        NewCount
    end.

count_pyramids(Grid, Rows, Cols, Row, Col) ->
    if Grid =:= [] orelse Row >= Rows orelse Col >= Cols orelse Grid =:= [] orelse lists:nth(Col+1, lists:nth(Row+1, Grid)) == 0 then
        0
    else
        count_pyramids_helper(Grid, Rows, Cols, Row, Col, 1)
    end.

count_pyramids_helper(Grid, Rows, Cols, Row, Col, Height) ->
    if Row + Height > Rows orelse Col - Height + 1 < 0 orelse Col + Height - 1 >= Cols then
        0
    else
        Valid = check_row(Grid, Rows, Cols, Row + Height - 1, Col - Height + 1, Col + Height - 1),
        if Valid then
            1 + count_pyramids_helper(Grid, Rows, Cols, Row, Col, Height + 1)
        else
            0
        end
    end.

count_inverted_pyramids(Grid, Rows, Cols, Row, Col) ->
    if Grid =:= [] orelse Row >= Rows orelse Col >= Cols orelse Grid =:= [] orelse lists:nth(Col+1, lists:nth(Row+1, Grid)) == 0 then
        0
    else
        count_inverted_pyramids_helper(Grid, Rows, Cols, Row, Col, 1)
    end.

count_inverted_pyramids_helper(Grid, Rows, Cols, Row, Col, Height) ->
    if Row - Height + 1 < 0 orelse Col - Height + 1 < 0 orelse Col + Height - 1 >= Cols then
        0
    else
        Valid = check_row(Grid, Rows, Cols, Row - Height + 1, Col - Height + 1, Col + Height - 1),
        if Valid then
            1 + count_inverted_pyramids_helper(Grid, Rows, Cols, Row, Col, Height + 1)
        else
            0
        end
    end.

check_row(Grid, Rows, Cols, Row, StartCol, EndCol) ->
    if Row < 0 orelse Row >= Rows then
        false
    else
        check_row_helper(lists:nth(Row+1, Grid), StartCol, EndCol, 1)
    end.

check_row_helper(Row, StartCol, EndCol, Col) ->
    if Col > length(Row) then
        true
    else if Col < StartCol orelse Col > EndCol then
        true
    else
        if lists:nth(Col, Row) == 1 then
            check_row_helper(Row, StartCol, EndCol, Col + 1)
        else
            false
        end
    end.