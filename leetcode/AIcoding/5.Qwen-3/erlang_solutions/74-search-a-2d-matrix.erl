-module(search_a_2d_matrix).
-export([search_matrix/2]).

search_matrix(Matrix, Target) ->
    search_matrix(Matrix, Target, 0, length(Matrix) - 1).

search_matrix(_, _, Low, High) when Low > High ->
    false;
search_matrix(Matrix, Target, Low, High) ->
    Mid = (Low + High) div 2,
    Row = lists:nth(Mid + 1, Matrix),
    case lists:keyfind(Target, 1, Row) of
        false ->
            if
                Target < lists:last(Row) ->
                    search_matrix(Matrix, Target, Low, Mid - 1);
                true ->
                    search_matrix(Matrix, Target, Mid + 1, High)
            end;
        _ ->
            true
    end.