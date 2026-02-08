-module(spiral_matrix).
-export([spiralOrder/1]).

spiralOrder(Matrix) ->
    spiralOrder(Matrix, []).

spiralOrder([], Acc) ->
    lists:reverse(Acc);
spiralOrder(Matrix, Acc) ->
    {TopRow, RemainingMatrix} = extractTopRow(Matrix),
    NewAcc = Acc ++ TopRow,
    case RemainingMatrix of
        [] ->
            lists:reverse(NewAcc);
        _ ->
            TransposedMatrix = transpose(RemainingMatrix),
            {RightColumn, RemainingTransposedMatrix} = extractTopRow(TransposedMatrix),
            ReversedRightColumn = lists:reverse(RightColumn),

            case RemainingTransposedMatrix of
                [] ->
                    lists:reverse(NewAcc ++ ReversedRightColumn);
                _ ->
                    NewMatrix = transpose(lists:reverse(RemainingTransposedMatrix)),
                    {BottomRow, RemainingNewMatrix} = extractTopRow(NewMatrix),
                    ReversedBottomRow = lists:reverse(BottomRow),

                    case RemainingNewMatrix of
                        [] ->
                            lists:reverse(NewAcc ++ ReversedRightColumn ++ ReversedBottomRow);
                        _ ->
                            TransposedNewMatrix = transpose(RemainingNewMatrix),
                            {LeftColumn, RemainingTransposedNewMatrix} = extractTopRow(TransposedNewMatrix),
                            ReversedLeftColumn = lists:reverse(LeftColumn),
                            spiralOrder(transpose(lists:reverse(RemainingTransposedNewMatrix)), NewAcc ++ ReversedRightColumn ++ ReversedBottomRow ++ ReversedLeftColumn)
                    end
            end
    end.

extractTopRow([Row|Rest]) ->
    {Row, Rest};
extractTopRow([]) ->
    {[], []}.

transpose([]) ->
    [].
transpose([[]|_]) ->
    [];
transpose(Matrix) ->
    [ [hd(Row) || Row <- Matrix] || _ <- hd(Matrix)] ++ transpose([tl(Row) || Row <- Matrix]).