-module(solution).
-export([num_enclaves/1]).

num_enclaves(Grid) ->
    N = length(Grid),
    M = length(hd(Grid)),
    Visited = lists:duplicate(N, lists:duplicate(M, false)),
    Grid1 = lists:map(fun(Row) -> lists:map(fun(X) -> if X =:= 1 -> true; true -> false end end, Row) end, Grid),
    {Visited1, _} = dfs(Grid1, Visited, 0, 0, N, M),
    count_enclaves(Grid1, Visited1).

dfs(Grid, Visited, I, J, N, M) ->
    if
        I < 0 orelse I >= N orelse J < 0 orelse J >= M orelse
        Visited[I][J] orelse Grid[I][J] =:= 0 ->
            {Visited, false};
        true ->
            Visited1 = lists:map(fun(X) -> lists:map(fun(Y) -> if X =:= I andalso Y =:= J -> true; true -> false end end, lists:nth(X + 1, Visited)) end, lists:seq(0, N - 1)),
            {Visited1, true} = dfs(Grid, Visited1, I + 1, J, N, M),
            {Visited1, _} = dfs(Grid, Visited1, I - 1, J, N, M),
            {Visited1, _} = dfs(Grid, Visited1, I, J + 1, N, M),
            {Visited1, _} = dfs(Grid, Visited1, I, J - 1, N, M),
            {Visited1, true}
    end.

count_enclaves(Grid, Visited) ->
    lists:foldl(fun({Row, I}) ->
        lists:foldl(fun({Value, J}, Acc) ->
            if Value =:= 1 andalso not Visited[I][J] -> Acc + 1; true -> Acc end
        end, Acc, lists:zip(Row, lists:seq(0, length(Row) - 1))
        )
    end, 0, lists:zip(Grid, lists:seq(0, length(Grid) - 1)).