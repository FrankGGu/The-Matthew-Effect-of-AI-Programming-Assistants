-module(solution).
-export([largest_submatrix/1]).

largest_submatrix(Matrix) ->
    Rows = length(Matrix),
    Cols = length(hd(Matrix)),
    Heights = lists:duplicate(Cols, 0),
    Matrices = lists:map(fun(Row) -> lists:map(fun(X) -> if X == 0 -> 0; true -> 1 end end, Row) end, Matrix),
    lists:foldl(fun(Row, Acc) -> 
        NewHeights = lists:map(fun({H, X}) -> if X == 0 -> 0; true -> H + 1 end end, lists:zip(Heights, Row)),
        MaxArea = lists:max(lists:map(fun(H, Col) -> H * (lists:nth(Col + 1, lists:sort(NewHeights))) end, NewHeights, lists:seq(1, Cols))),
        {NewHeights, max(Acc, MaxArea)} 
    end, {Heights, 0}, Matrices).