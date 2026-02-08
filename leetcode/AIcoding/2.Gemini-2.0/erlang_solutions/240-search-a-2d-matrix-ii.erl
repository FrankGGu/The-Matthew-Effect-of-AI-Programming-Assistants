-module(search_matrix).
-export([search_matrix/2]).

search_matrix(Matrix, Target) ->
    search_matrix(Matrix, Target, 0, length(hd(Matrix)) - 1).

search_matrix(_Matrix, _Target, _Row, -1) ->
    false;
search_matrix(_Matrix, _Target, _Row, _Col) when _Row >= length(_Matrix) ->
    false;
search_matrix(Matrix, Target, Row, Col) ->
    Val = lists:nth(Col + 1, lists:nth(Row + 1, Matrix)),
    case Val of
        Target ->
            true;
        Val when Val < Target ->
            search_matrix(Matrix, Target, Row + 1, Col);
        Val when Val > Target ->
            search_matrix(Matrix, Target, Row, Col - 1)
    end.