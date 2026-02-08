-module(solution).
-export([regions_cut_by_slashes/1]).

regions_cut_by_slashes(Grid) ->
    N = length(Grid),
    Matrix = lists:map(fun(Row) -> lists:map(fun(C) -> if C =:= $/ -> 1; true -> 0 end end, Row) end, Grid),
    Visited = lists:duplicate(N, lists:duplicate(N, false)),
    CountRegions(Matrix, Visited, N, 0).

CountRegions(Matrix, Visited, N, Count) ->
    case find_unvisited(Matrix, Visited, N) of
        {Row, Col} ->
            NewVisited = mark_region(Matrix, Visited, Row, Col, N),
            CountRegions(Matrix, NewVisited, N, Count + 1);
        undefined ->
            Count
    end.

find_unvisited(Matrix, Visited, N) ->
    lists:foldl(fun({Row, Col}, Acc) ->
        case Acc of
            {_, _} -> Acc;
            _ when not (Visited(Row, Col)) andalso (Matrix(Row, Col) =:= 0) -> {Row, Col};
            _ -> Acc
        end
    end, undefined, lists:seq(0, N - 1)).

mark_region(Matrix, Visited, Row, Col, N) ->
    case (Row < 0 orelse Row >= N orelse Col < 0 orelse Col >= N orelse Visited(Row, Col) orelse Matrix(Row, Col) =:= 1) of
        true -> Visited;
        false ->
            NewVisited = lists:map(fun(X, Y) -> if X =:= Row andalso Y =:= Col -> true; true -> X end end, Visited),
            lists:foldl(fun({DRow, DCol}, Acc) ->
                mark_region(Matrix, Acc, Row + DRow, Col + DCol, N)
            end, NewVisited, [{1, 0}, {-1, 0}, {0, 1}, {0, -1}])
    end.