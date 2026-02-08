-module(safest_path).
-export([max_safeness_index/2]).

max_safeness_index(Grid, k) ->
    N = length(Grid),
    M = length(hd(Grid)),
    Visited = lists:duplicate(N, lists:duplicate(M, false)),
    {MaxSafeness, _} = max_safeness_index_helper(Grid, Visited, 0, 0, k, 0, 0, N, M),
    MaxSafeness.

max_safeness_index_helper(Grid, Visited, X, Y, K, CurrentSafeness, MaxSafeness, N, M) ->
    if
        X < 0; Y < 0; X >= N; Y >= M -> {MaxSafeness, CurrentSafeness};
        Visited[X][Y] -> {MaxSafeness, CurrentSafeness}
    end,
    NewVisited = lists:map(fun(Row, I) -> lists:map(fun(Cell, J) -> if I == X, J == Y -> true; true -> Cell end end, Row) end, Grid),
    NewMaxSafeness = max(CurrentSafeness + Grid[X][Y], MaxSafeness),
    lists:foldl(fun({dx, dy}, Acc) ->
        max_safeness_index_helper(NewVisited, Acc, X + dx, Y + dy, K, NewMaxSafeness, MaxSafeness, N, M)
    end, NewMaxSafeness, [{1, 0}, {0, 1}, {-1, 0}, {0, -1}]).