-module(spiral_order).
-export([spiral_order/1]).

spiral_order(Matrix) ->
    spiral_order(Matrix, []).

spiral_order([], Result) ->
    lists:reverse(Result);
spiral_order(Matrix, Result) ->
    [First | Rest] = Matrix,
    NewResult = Result ++ First,
    case Rest of
        [] -> lists:reverse(NewResult);
        _ ->
            Right = lists:map(fun(Row) -> lists:last(Row) end, Rest),
            NewResult2 = NewResult ++ Right,
            Bottom = lists:reverse(lists:tl(lists:last(Rest))),
            NewResult3 = NewResult2 ++ Bottom,
            Left = lists:map(fun(Row) -> lists:nth(2, Row) end, lists:tl(Rest)),
            NewResult4 = NewResult3 ++ Left,
            NewMatrix = lists:map(fun(Row) -> lists:tl(lists:reverse(lists:tl(lists:reverse(Row)))) end, lists:tl(Rest)),
            spiral_order(NewMatrix, NewResult4)
    end.