-module(equalequalsumgridpartitionii).
-export([equal_sum_grid_partition/1]).

equal_sum_grid_partition(Grid) ->
    Rows = length(Grid),
    Cols = length(hd(Grid)),
    Total = lists:foldl(fun(Row, Acc) -> lists:foldl(fun(X, A) -> A + X end, Acc, Row) end, 0, Grid),
    if
        Total rem 2 /= 0 -> false;
        true ->
            Target = Total div 2,
            {ok, _} = dfs(Grid, 0, 0, 0, Target, Rows, Cols, []),
            true
    end.

dfs(_, _, _, _, _, _, _, _) -> {error, false};
dfs(Grid, R, C, Sum, Target, Rows, Cols, Visited) ->
    case lists:keymember({R, C}, 1, Visited) of
        true -> {error, false};
        false ->
            NewVisited = [{R, C} | Visited],
            NewSum = Sum + lists:nth(R+1, Grid) -- [C],
            if
                NewSum == Target -> {ok, true};
                NewSum > Target -> {error, false};
                true ->
                    case dfs(Grid, R+1, 0, NewSum, Target, Rows, Cols, NewVisited) of
                        {ok, true} -> {ok, true};
                        _ ->
                            case dfs(Grid, R, C+1, NewSum, Target, Rows, Cols, NewVisited) of
                                {ok, true} -> {ok, true};
                                _ ->
                                    case dfs(Grid, R-1, C, NewSum, Target, Rows, Cols, NewVisited) of
                                        {ok, true} -> {ok, true};
                                        _ ->
                                            case dfs(Grid, R, C-1, NewSum, Target, Rows, Cols, NewVisited) of
                                                {ok, true} -> {ok, true};
                                                _ -> {error, false}
                                            end
                                    end
                            end
                    end
            end
    end.