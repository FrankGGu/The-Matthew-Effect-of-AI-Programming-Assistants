-module(solution).
-export([difference/1]).

difference(Matrix) ->
    Diagonal1 = distinct_diagonal_values(Matrix, 0, 0, length(Matrix)),
    Diagonal2 = distinct_diagonal_values(Matrix, 0, length(Matrix)-1, length(Matrix)),
    length(Diagonal1) - length(Diagonal2).

distinct_diagonal_values(Matrix, Row, Col, Size) ->
    if
        Row >= Size -> []
    end ++ 
    if
        Col < 0 -> []
    end ++ 
    if
        Col >= Size -> []
    end ++ 
    [lists:nth(Col + 1, lists:nth(Row + 1, Matrix))] ++ 
    distinct_diagonal_values(Matrix, Row + 1, Col - 1, Size).