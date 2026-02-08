-module(solution).
-export([min_cells/2]).

min_cells(Grid, K) ->
    N = length(Grid),
    M = length(hd(Grid)),
    Visited = lists:duplicate(N, lists:duplicate(M, false)),
    min_cells_helper(Grid, K, 0, 0, Visited).

min_cells_helper(Grid, K, X, Y, Visited) ->
    N = length(Grid),
    M = length(hd(Grid)),
    if
        X >= N orelse Y >= M -> 
            infinite; % Out of bounds
        lists:nth(Y + 1, lists:nth(X + 1, Visited)) -> 
            infinite; % Already visited
        true ->
            CurrentValue = lists:nth(Y + 1, lists:nth(X + 1, Grid)),
            if
                CurrentValue > K -> 
                    infinite;
                true ->
                    NewVisited = lists:map(fun(Row, RIndex) -> 
                        if RIndex == X -> 
                            lists:map(fun(Cell, CIndex) -> 
                                if CIndex == Y -> 
                                    true; 
                                true -> 
                                    Cell 
                                end 
                            end, Row) 
                        else 
                            Row 
                        end 
                    end, Visited, lists:seq(0, N-1)),
                    VisitedCount = count_visited(NewVisited, N, M),
                    min_cells_helper(Grid, K, X + 1, Y, NewVisited) + 
                    min_cells_helper(Grid, K, X, Y + 1, NewVisited) + 
                    min_cells_helper(Grid, K, X, Y - 1, NewVisited) + 
                    min_cells_helper(Grid, K, X - 1, Y, NewVisited) + 
                    VisitedCount
            end
    end.

count_visited(Visited, N, M) ->
    lists:sum(lists:map(fun(Row) -> lists:sum(Row) end, Visited)).