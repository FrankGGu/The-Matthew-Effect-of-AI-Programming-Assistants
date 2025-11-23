-module(largest_1_bordered_square).
-export([largest1BorderedSquare/1]).

largest1BorderedSquare(Grid) ->
    Rows = length(Grid),
    Cols = length(hd(Grid)),
    MaxSide = min(Rows, Cols),
    largest1BorderedSquareHelper(Grid, Rows, Cols, MaxSide).

largest1BorderedSquareHelper(Grid, Rows, Cols, Side) ->
    if
        Side =< 0 ->
            0;
        true ->
            case hasSquare(Grid, Rows, Cols, Side) of
                true ->
                    Side * Side;
                false ->
                    largest1BorderedSquareHelper(Grid, Rows, Cols, Side - 1)
            end
    end.

hasSquare(Grid, Rows, Cols, Side) ->
    lists:any(fun(Row) -> lists:any(fun(Col) -> isSquare(Grid, Rows, Cols, Row, Col, Side),
                                      lists:seq(0, Cols - Side)),
                   lists:seq(0, Rows - Side)).

isSquare(Grid, Rows, Cols, Row, Col, Side) ->
    if
        Row + Side > Rows orelse Col + Side > Cols ->
            false;
        true ->
            TopBorder = lists:all(fun(C) -> lists:nth(C+1, lists:nth(Row+1, Grid)) == 1, lists:seq(Col, Col + Side - 1)),
            BottomBorder = lists:all(fun(C) -> lists:nth(C+1, lists:nth(Row + Side, Grid)) == 1, lists:seq(Col, Col + Side - 1)),
            LeftBorder = lists:all(fun(R) -> lists:nth(Col+1, lists:nth(R+1, Grid)) == 1, lists:seq(Row, Row + Side - 1)),
            RightBorder = lists:all(fun(R) -> lists:nth(Col + Side, lists:nth(R+1, Grid)) == 1, lists:seq(Row, Row + Side - 1)),

            TopBorder andalso BottomBorder andalso LeftBorder andalso RightBorder
    end.