-module(solution).
-export([sum_of_matrix_after_queries/2]).

sum_of_matrix_after_queries(N, Queries) ->
    Rows = dict:new(),
    Cols = dict:new(),
    Result = 0,
    sum_of_matrix_after_queries_helper(N, Queries, Rows, Cols, Result).

sum_of_matrix_after_queries_helper(N, [], Rows, Cols, Result) ->
    Result;
sum_of_matrix_after_queries_helper(N, [[Type, Index, Val] | Rest], Rows, Cols, Result) ->
    case Type of
        0 ->
            case dict:is_key(Index, Rows) of
                true ->
                    sum_of_matrix_after_queries_helper(N, Rest, Rows, Cols, Result);
                false ->
                    MissingCols = lists:filter(fun(Col) -> not dict:is_key(Col, Cols) end, lists:seq(0, N - 1)),
                    NewResult = Result + Val * length(MissingCols),
                    NewRows = dict:store(Index, true, Rows),
                    sum_of_matrix_after_queries_helper(N, Rest, NewRows, Cols, NewResult)
            end;
        1 ->
            case dict:is_key(Index, Cols) of
                true ->
                    sum_of_matrix_after_queries_helper(N, Rest, Rows, Cols, Result);
                false ->
                    MissingRows = lists:filter(fun(Row) -> not dict:is_key(Row, Rows) end, lists:seq(0, N - 1)),
                    NewResult = Result + Val * length(MissingRows),
                    NewCols = dict:store(Index, true, Cols),
                    sum_of_matrix_after_queries_helper(N, Rest, Rows, NewCols, NewResult)
            end
    end.