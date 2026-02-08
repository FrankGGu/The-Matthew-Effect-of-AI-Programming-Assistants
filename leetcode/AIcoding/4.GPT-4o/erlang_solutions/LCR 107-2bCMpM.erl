-module(solution).
-export([update_matrix/1]).

update_matrix(Matrix) ->
    Rows = length(Matrix),
    Cols = length(hd(Matrix)),
    Max = Rows + Cols,
    Distances = lists:map(fun(_) -> lists:duplicate(Cols, Max) end, lists:seq(1, Rows)),
    Distances1 = update_distances(Matrix, Distances, Rows, Cols),
    update_distances_back(Matrix, Distances1, Rows, Cols).

update_distances([], Distances, _, _) -> Distances;
update_distances([Row | Rest], Distances, Rows, Cols) ->
    Distances1 = lists:map(fun({Value, Index}) ->
        case Value of
            0 -> 0;
            _ -> case Index of
                0 -> 1 + lists:nth(Index + 1, Distances);
                _ -> min(1 + lists:nth(Index - 1, Distances), lists:nth(Index, Distances))
            end
        end
    end, lists:zip(Row, lists:seq(0, Cols - 1))),
    Distances2 = update_distances(Rest, Distances1, Rows - 1, Cols),
    lists:zip_with(fun(X, Y) -> min(X, Y) end, Distances1, Distances2).

update_distances_back([], Distances, _, _) -> Distances;
update_distances_back([Row | Rest], Distances, Rows, Cols) ->
    Distances1 = lists:map(fun({Value, Index}) ->
        case Value of
            0 -> 0;
            _ -> case Index of
                Cols - 1 -> 1 + lists:nth(Index - 1, Distances);
                _ -> min(1 + lists:nth(Index + 1, Distances), lists:nth(Index, Distances))
            end
        end
    end, lists:zip(Row, lists:seq(0, Cols - 1))),
    Distances2 = update_distances_back(Rest, Distances1, Rows - 1, Cols),
    lists:zip_with(fun(X, Y) -> min(X, Y) end, Distances1, Distances2).