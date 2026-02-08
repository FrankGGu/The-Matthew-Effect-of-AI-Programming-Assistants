-module(solution).
-export([sumAfterQueries/2]).

sumAfterQueries(N, Queries) ->
    Matrix = lists:duplicate(N, lists:duplicate(N, 0)),
    processQueries(Matrix, Queries),
    sumMatrix(Matrix).

processQueries(Matrix, []) ->
    Matrix;
processQueries(Matrix, [{Type, I, J} | Rest]) ->
    case Type of
        0 -> 
            NewMatrix = updateRow(Matrix, I, J),
            processQueries(NewMatrix, Rest);
        1 -> 
            NewMatrix = updateCol(Matrix, I, J),
            processQueries(NewMatrix, Rest)
    end.

updateRow(Matrix, I, Val) ->
    lists:map(fun(Row) ->
        lists:sublist(Row, I) ++ [Val] ++ lists:nthtail(I+1, Row)
    end, Matrix).

updateCol(Matrix, J, Val) ->
    lists:foldl(fun(I, Acc) ->
        lists:sublist(Acc, I) ++ [lists:nth(I, Acc) ++ [Val]] ++ lists:nthtail(I+1, Acc)
    end, Matrix, lists:seq(1, length(Matrix))).

sumMatrix(Matrix) ->
    lists:sum(lists:map(fun(Row) -> lists:sum(Row) end, Matrix)).