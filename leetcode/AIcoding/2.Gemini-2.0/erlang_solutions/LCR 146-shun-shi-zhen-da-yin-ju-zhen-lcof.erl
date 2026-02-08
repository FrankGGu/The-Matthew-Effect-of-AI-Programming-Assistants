-module(spiral_matrix).
-export([spiralOrder/1]).

spiralOrder(Matrix) ->
    spiralOrder(Matrix, []).

spiralOrder([], Acc) ->
    lists:reverse(Acc);
spiralOrder(Matrix, Acc) ->
    case Matrix of
        [] ->
            lists:reverse(Acc);
        [[]] ->
            lists:reverse(Acc);
        _ ->
            TopRow = hd(Matrix),
            RightColumn = [lists:nth(length(hd(Matrix)), Row) || Row <- tl(Matrix)],
            RemainingMatrix = [lists:sublist(Row, 1, length(hd(Matrix)) - 1) || Row <- lists:reverse(tl(Matrix))],
            BottomRow = case RemainingMatrix of
                            [] -> [];
                            _ -> lists:reverse(hd(lists:last(RemainingMatrix)))
                        end,
            LeftColumn = [hd(Row) || Row <- lists:reverse(lists:sublist(RemainingMatrix, 1, length(RemainingMatrix) -1))],

            NewAcc = TopRow ++ RightColumn ++ BottomRow ++ LeftColumn,
            NewMatrix = case RemainingMatrix of
                [] -> [];
                _ -> lists:sublist(RemainingMatrix, 1, length(RemainingMatrix) -1)
            end,
            spiralOrder(NewMatrix, Acc ++ NewAcc)
    end.