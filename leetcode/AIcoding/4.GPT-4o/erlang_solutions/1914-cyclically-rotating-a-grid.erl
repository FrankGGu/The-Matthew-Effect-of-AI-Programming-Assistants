-module(solution).
-export([rotate_grid/2]).

rotate_grid(Grid, K) ->
    Rows = length(Grid),
    Cols = length(hd(Grid)),
    K1 = K rem (2 * (Rows + Cols - 2)),
    Rotated = rotate(Grid, K1, Rows, Cols),
    Rotated.

rotate(Grid, 0, _, _) -> Grid;
rotate(Grid, K, Rows, Cols) ->
    OuterLayers = min(Rows, Cols) div 2,
    NewGrid = lists:foldl(fun(Layer, Acc) ->
        rotate_layer(Acc, Layer, K, Rows, Cols)
    end, Grid, lists:seq(0, OuterLayers - 1)),
    NewGrid.

rotate_layer(Grid, Layer, K, Rows, Cols) ->
    TopRow = Layer,
    BottomRow = Rows - Layer - 1,
    LeftCol = Layer,
    RightCol = Cols - Layer - 1,

    Top = lists:sublist(Grid, TopRow + 1),
    Bottom = lists:sublist(Grid, BottomRow),

    Left = lists:map(fun(Row) -> lists:nth(LeftCol + 1, Row) end, Top),
    Right = lists:map(fun(Row) -> lists:nth(RightCol + 1, Row) end, Bottom),

    LayerLength = (RightCol - LeftCol + 1) + (BottomRow - TopRow + 1) + (RightCol - LeftCol + 1) + (BottomRow - TopRow + 1) - 4,
    RotatedK = K rem LayerLength,

    NewTop = rotate_row(Top, Left, RotatedK, RightCol - LeftCol + 1),
    NewBottom = rotate_row(Bottom, Right, RotatedK, RightCol - LeftCol + 1),

    NewGrid = lists:map(fun(Row, RowIdx) ->
        case RowIdx of
            TopRow -> NewTop;
            BottomRow -> NewBottom;
            _ -> Row
        end
    end, Grid, lists:seq(1, length(Grid))),

    NewGrid.

rotate_row(Row, Elements, K, Length) ->
    Elements = lists:sublist(Elements, K + 1),
    lists:append(Row, lists:sublist(Row, 1, Length - K - 1)).