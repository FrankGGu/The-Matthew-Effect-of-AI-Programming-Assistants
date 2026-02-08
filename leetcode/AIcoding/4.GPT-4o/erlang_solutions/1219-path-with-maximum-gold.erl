-module(solution).
-export([get_maximum_gold/1]).

get_maximum_gold(Grid) ->
    MaxGold = lists:foldl(fun(Row, Acc) -> lists:max([Acc, get_gold_in_row(Row, Grid)]) end, 0, Grid),
    MaxGold.

get_gold_in_row(Row, Grid) ->
    lists:foldl(fun({X, Y}, Acc) -> max(Acc, dfs(X, Y, Grid, []).) end, 0, row_indices(Row)).

dfs(X, Y, Grid, Visited) ->
    if
        X < 0; Y < 0; X >= length(Grid); Y >= length(hd(Grid)); lists:member({X, Y}, Visited) -> 0;
        true -> 
            Gold = lists:nth(Y + 1, lists:nth(X + 1, Grid)),
            NewVisited = [{X, Y} | Visited],
            NewGold = Gold + dfs(X + 1, Y, Grid, NewVisited) +
                      dfs(X - 1, Y, Grid, NewVisited) +
                      dfs(X, Y + 1, Grid, NewVisited) +
                      dfs(X, Y - 1, Grid, NewVisited),
            NewGold
    end.

row_indices(Row) ->
    lists:foldl(fun(X, Acc) -> [{Row, X} | Acc] end, [], lists:seq(0, length(hd(Row)) - 1)).