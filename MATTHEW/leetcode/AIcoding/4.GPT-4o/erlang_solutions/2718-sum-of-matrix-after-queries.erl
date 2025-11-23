-module(solution).
-export([matrix_sum/3]).

matrix_sum(N, M, Queries) ->
    Matrix = lists:duplicate(N, lists:duplicate(M, 0)),
    lists:foldl(fun({Op, X, Y}, Acc) ->
        case Op of
            0 -> lists:map(fun(R) -> lists:map(fun(E) -> E + X end, R) end, Acc);
            1 -> lists:map(fun(R) -> lists:map(fun(E) -> E + Y end, R) end, Acc);
            _ -> Acc
        end
    end, Matrix, Queries).