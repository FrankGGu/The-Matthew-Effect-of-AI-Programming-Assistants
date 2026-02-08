-module(solution).
-export([largest1BorderedSquare/1]).

largest1BorderedSquare(Matrix) ->
    Rows = length(Matrix),
    Cols = if Rows > 0 -> length(hd(Matrix)); _ -> 0 end,
    Matrix1 = lists:map(fun Row -> lists:map(fun X -> if X =:= 1 -> 1; _ -> 0 end) end, Matrix),
    Sizes = lists:map(fun _ -> lists:duplicate(Cols, 0) end, lists:duplicate(Rows, 0)),
    MaxSize = lists:foldl(fun {Row, RIdx}, Acc -> 
        lists:foldl(fun {Col, CIdx}, Acc1 -> 
            if Matrix1[[RIdx, CIdx]] =:= 1 ->
                Size = min(Acc1[[RIdx-1, CIdx]], min(Acc1[[RIdx, CIdx-1]], Acc1[[RIdx-1, CIdx-1]])) + 1,
                Sizes[[RIdx, CIdx]] = Size,
                max(Acc, Size);
            _ -> Acc
            end
        end, Acc, lists:zip(Matrix1, lists:seq(1, Cols))),
        Acc
    end, 0, lists:zip(Matrix1, lists:seq(1, Rows))),
    MaxSize * MaxSize.