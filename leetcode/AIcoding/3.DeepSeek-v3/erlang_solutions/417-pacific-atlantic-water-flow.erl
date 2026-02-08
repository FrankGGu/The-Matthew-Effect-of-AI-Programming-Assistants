-module(solution).
-export([pacific_atlantic/1]).

pacific_atlantic(Matrix) ->
    case Matrix of
        [] -> [];
        _ ->
            Rows = length(Matrix),
            Cols = length(hd(Matrix)),
            Pacific = sets:new(),
            Atlantic = sets:new(),
            Pacific1 = pacific_dfs(Matrix, Rows, Cols, Pacific),
            Atlantic1 = atlantic_dfs(Matrix, Rows, Cols, Atlantic),
            Result = sets:to_list(sets:intersection(Pacific1, Atlantic1)),
            lists:sort(Result)
    end.

pacific_dfs(Matrix, Rows, Cols, Visited) ->
    Queue = lists:append([[{0, C} || C <- lists:seq(0, Cols - 1)]], 
                          [{R, 0} || R <- lists:seq(1, Rows - 1)]]),
    dfs(Matrix, Rows, Cols, Queue, Visited).

atlantic_dfs(Matrix, Rows, Cols, Visited) ->
    Queue = lists:append([[{Rows - 1, C} || C <- lists:seq(0, Cols - 1)]],
                         [{R, Cols - 1} || R <- lists:seq(0, Rows - 2)]]),
    dfs(Matrix, Rows, Cols, Queue, Visited).

dfs(Matrix, Rows, Cols, Queue, Visited) ->
    case Queue of
        [] -> Visited;
        [{R, C} | Rest] ->
            case sets:is_element({R, C}, Visited) of
                true -> dfs(Matrix, Rows, Cols, Rest, Visited);
                false ->
                    Visited1 = sets:add_element({R, C}, Visited),
                    Neighbors = [{R + DR, C + DC} || {DR, DC} <- [{-1, 0}, {1, 0}, {0, -1}, {0, 1}],
                                                    R + DR >= 0, R + DR < Rows,
                                                    C + DC >= 0, C + DC < Cols,
                                                    not sets:is_element({R + DR, C + DC}, Visited1),
                                                    get_val(Matrix, R + DR, C + DC) >= get_val(Matrix, R, C)],
                    dfs(Matrix, Rows, Cols, Rest ++ Neighbors, Visited1)
            end
    end.

get_val(Matrix, R, C) ->
    lists:nth(C + 1, lists:nth(R + 1, Matrix)).