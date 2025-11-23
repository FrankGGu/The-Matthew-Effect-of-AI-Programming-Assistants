-module(solution).
-export([number_of_paths/3]).

number_of_paths(Matrix, K) ->
    Rows = length(Matrix),
    Cols = length(hd(Matrix)),
    Paths = lists:duplicate(Rows, lists:duplicate(Cols, 0)),
    Paths = calculate_paths(Matrix, K, 0, 0, 0, Paths),
    lists:nth(Rows, lists:nth(Cols, Paths)).

calculate_paths(_, _, Row, Col, Sum, Paths) when Row < 0; Row >= length(Paths); Col < 0; Col >= length(hd(Paths)) ->
    Paths;
calculate_paths(Matrix, K, Row, Col, Sum, Paths) ->
    NewSum = (Sum + lists:nth(Col, lists:nth(Row, Matrix))) rem K,
    NewPaths = lists:map(fun(X) -> lists:map(fun(Y) -> Y + (if X == 0 -> 1; true -> 0 end) end) end, Paths),
    NewPaths1 = lists:map(fun(X) -> lists:nth(Col, X) + 1 end, NewPaths),
    NewPaths2 = calculate_paths(Matrix, K, Row + 1, Col, NewSum, NewPaths1),
    calculate_paths(Matrix, K, Row, Col + 1, NewSum, NewPaths2).