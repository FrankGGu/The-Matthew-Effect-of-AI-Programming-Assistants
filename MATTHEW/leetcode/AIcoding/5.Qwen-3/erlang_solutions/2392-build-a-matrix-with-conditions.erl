-module(solution).
-export([build_matrix/3]).

build_matrix(K, M, N) ->
    Rows = lists:seq(1, M),
    Cols = lists:seq(1, N),
    Matrix = lists:foldl(fun(Row, Acc) -> 
        lists:foldl(fun(Col, Acc2) -> 
            case is_valid(Row, Col, K, M, N) of
                true -> [Col | Acc2];
                false -> Acc2
            end
        end, [], Cols)
    end, [], Rows),
    lists:map(fun(Row) -> lists:reverse(Row) end, Matrix).

is_valid(Row, Col, K, M, N) ->
    Row <= K andalso Col <= K andalso (Row + Col) > K.