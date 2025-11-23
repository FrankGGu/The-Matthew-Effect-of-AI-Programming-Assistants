-module(solution).
-export([spiralOrder/1]).

spiralOrder(Matrix) ->
    spiralOrder(Matrix, []).

spiralOrder([], Acc) ->
    lists:reverse(Acc);
spiralOrder(Matrix, Acc) ->
    {Top, Rest} = lists:split(1, Matrix),
    Acc1 = Acc ++ lists:flatten(Top),
    NewMatrix = lists:map(fun(Row) -> tl(Row) end, Rest),
    spiralOrder(NewMatrix, Acc1).