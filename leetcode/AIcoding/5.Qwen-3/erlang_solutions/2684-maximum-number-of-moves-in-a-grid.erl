-module(maximum_number_of_moves_in_a_grid).
-export([maxMoves/2]).

maxMoves(Grid, k) ->
    Rows = length(Grid),
    Cols = length(hd(Grid)),
    Visited = array:new({0, Rows-1}, {default, array:new({0, Cols-1}, {default, false})}),
    MaxSteps = 0,
    lists:foldl(fun(Row, Acc) ->
        lists:foldl(fun(Col, Acc2) ->
            if
                grid_val(Grid, Row, Col) < grid_val(Grid, Row+1, Col) andalso Row+1 < Rows ->
                    Steps = dfs(Grid, Row, Col, k, Visited, 0),
                    max(Acc2, Steps);
                true ->
                    Acc2
            end
        end, Acc, lists:seq(0, Cols-1))
    end, MaxSteps, lists:seq(0, Rows-1)).

grid_val(Grid, Row, Col) ->
    lists:nth(Row+1, Grid) -- [Col].

dfs(_, _, _, 0, _, Steps) ->
    Steps;
dfs(Grid, Row, Col, K, Visited, Steps) ->
    case array:get(Row, Visited) of
        VisitedRow ->
            case array:get(Col, VisitedRow) of
                true ->
                    Steps;
                _ ->
                    NewVisited = array:set(Row, array:set(Col, true, VisitedRow), Visited),
                    NextSteps = steps_from_neighbors(Grid, Row, Col, K-1, NewVisited, Steps),
                    array:set(Row, array:set(Col, false, VisitedRow), Visited),
                    NextSteps
            end
    end.

steps_from_neighbors(Grid, Row, Col, K, Visited, Steps) ->
    MaxSteps = Steps,
    Neighbors = [],
    lists:foldl(fun({NR, NC}, Acc) ->
        if
            NR >= 0, NR < length(Grid), NC >= 0, NC < length(hd(Grid)) ->
                if
                    grid_val(Grid, Row, Col) < grid_val(Grid, NR, NC) ->
                        NewSteps = dfs(Grid, NR, NC, K, Visited, Steps + 1),
                        max(Acc, NewSteps);
                    true ->
                        Acc
                end;
            true ->
                Acc
        end
    end, MaxSteps, Neighbors).

max(A, B) when A > B -> A;
max(_, B) -> B.