-module(solution).
-export([search_matrix/2]).

search_matrix(Matrix, Target) ->
    case Matrix of
        [] -> false;
        _ -> search(Matrix, Target, 0, length(Matrix) - 1)
    end.

search([], _, _, _) -> false;
search(Matrix, Target, Row, Col) when Row >= length(Matrix) -> false;
search(Matrix, Target, Row, Col) when Col < 0 -> search(Matrix, Target, Row + 1, length(hd(Matrix)) - 1);
search(Matrix, Target, Row, Col) ->
    case lists:nth(Col + 1, lists:nth(Row + 1, Matrix)) of
        X when X == Target -> true;
        X when X < Target -> search(Matrix, Target, Row, Col + 1);
        _ -> search(Matrix, Target, Row, Col - 1)
    end.