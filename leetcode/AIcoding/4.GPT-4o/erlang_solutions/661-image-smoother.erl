-module(image_smoother).
-export([imageSmoother/1]).

imageSmoother(Image) ->
    Rows = length(Image),
    Cols = length(hd(Image)),
    lists:map(fun(Row) -> 
        lists:map(fun(Col) -> 
            smooth_pixel(Image, Row, Col, Rows, Cols) 
        end, lists:seq(1, Cols)) 
    end, lists:seq(1, Rows)).

smooth_pixel(Image, Row, Col, Rows, Cols) ->
    {Sum, Count} = lists:foldl(fun({dx, dy}, {SumAcc, CountAcc}) ->
        NewRow = Row + dx,
        NewCol = Col + dy,
        case is_valid(NewRow, NewCol, Rows, Cols) of
            true -> 
                {SumAcc + lists:nth(NewRow, Image) [NewCol], CountAcc + 1};
            false -> 
                {SumAcc, CountAcc}
        end
    end, {0, 0}, [{-1, -1}, {-1, 0}, {-1, 1}, {0, -1}, {0, 0}, {0, 1}, {1, -1}, {1, 0}, {1, 1}]),
    Sum div Count.

is_valid(Row, Col, Rows, Cols) ->
    Row > 0, Row =< Rows, Col > 0, Col =< Cols.