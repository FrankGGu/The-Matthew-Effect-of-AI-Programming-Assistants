-module(solution).
-export([search_matrix/2]).

search_matrix(Matrix, Target) ->
    search_matrix(Matrix, Target, 0, length(Matrix) - 1).

search_matrix(_, _, Row, Col) when Row < 0; Col < 0 -> false;
search_matrix(Matrix, Target, Row, Col) ->
    [MidRow | _] = lists:nth(Row + 1, Matrix),
    MidVal = lists:nth(Col + 1, MidRow),
    case MidVal of
        Target -> true;
        Val when Val < Target -> search_matrix(Matrix, Target, Row + 1, Col);
        _ -> search_matrix(Matrix, Target, Row, Col - 1)
    end.