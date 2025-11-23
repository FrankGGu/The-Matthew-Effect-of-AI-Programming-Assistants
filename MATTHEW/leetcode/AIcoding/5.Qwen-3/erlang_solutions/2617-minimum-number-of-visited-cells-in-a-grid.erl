-module(min_visited_cells).
-export([minimumVisitedCells/1]).

minimumVisitedCells(Grid) ->
    Rows = length(Grid),
    Cols = length(hd(Grid)),
    {_, _, _} = lists:foldl(fun(Row, {RowIdx, Acc, Visited}) ->
        lists:foldl(fun(Cell, {ColIdx, Acc2, Visited2}) ->
            case Cell of
                0 -> 
                    {ColIdx + 1, Acc2, Visited2};
                _ ->
                    NewAcc = case Acc2 of
                        [] -> [{RowIdx, ColIdx}];
                        _ -> [{RowIdx, ColIdx} | Acc2]
                    end,
                    NewVisited = maps:update({RowIdx, ColIdx}, 1, Visited2),
                    {ColIdx + 1, NewAcc, NewVisited}
            end
        end, {0, [], #{}}, Row), {RowIdx + 1, Acc, Visited}
    end, {0, [], #{}}, Grid),
    Result = bfs(Grid, Rows, Cols),
    lists:last(Result).

bfs(Grid, Rows, Cols) ->
    Q = queue:new(),
    Visited = maps:new(),
    lists:foreach(fun({R, C}) -> 
        queue:in({R, C}, Q),
        maps:put({R, C}, 1, Visited)
    end, getStartPoints(Grid)),
    bfsLoop(Q, Visited, Grid, Rows, Cols, 1).

bfsLoop(Q, Visited, Grid, Rows, Cols, Steps) ->
    if
        queue:is_empty(Q) -> [];
        true ->
            {{R, C}, Q1} = queue:out(Q),
            Neighbors = getNeighbors(Grid, R, C, Rows, Cols),
            lists:foreach(fun({NR, NC}) ->
                case maps:get({NR, NC}, Visited, undefined) of
                    undefined ->
                        maps:put({NR, NC}, Steps + 1, Visited),
                        queue:in({NR, NC}, Q1);
                    _ -> ok
                end
            end, Neighbors),
            [Steps | bfsLoop(Q1, Visited, Grid, Rows, Cols, Steps + 1)]
    end.

getStartPoints(Grid) ->
    lists:foldl(fun(Row, Acc) ->
        lists:foldl(fun(Cell, Acc2) ->
            case Cell of
                0 -> Acc2;
                _ -> [{R, C} | Acc2]
            end
        end, Acc, Row)
    end, [], Grid).

getNeighbors(Grid, R, C, Rows, Cols) ->
    Directions = [{-1, 0}, {1, 0}, {0, -1}, {0, 1}],
    lists:filtermap(fun({DR, DC}) ->
        NR = R + DR,
        NC = C + DC,
        case NR >= 0 andalso NR < Rows andalso NC >= 0 andalso NC < Cols of
            true -> 
                Cell = lists:nth(NR + 1, Grid),
                Value = lists:nth(NC + 1, Cell),
                if
                    Value == 0 -> {true, {NR, NC}};
                    _ -> false
                end;
            false -> false
        end
    end, Directions).