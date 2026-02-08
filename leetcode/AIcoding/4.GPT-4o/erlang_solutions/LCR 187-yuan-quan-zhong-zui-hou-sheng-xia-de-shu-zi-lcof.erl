-module(solution).
-export([findCircleNum/1]).

findCircleNum(M) ->
    N = length(M),
    Visited = lists:duplicate(N, false),
    dfs(M, Visited, 0).

dfs(M, Visited, i) when i >= length(Visited) -> 0;
dfs(M, Visited, i) ->
    case lists:nth(i + 1, Visited) of
        true -> dfs(M, Visited, i + 1);
        false ->
            NewVisited = mark_visited(M, Visited, i),
            1 + dfs(M, NewVisited, i + 1)
    end.

mark_visited(M, Visited, i) ->
    lists:mapfoldl(fun
        (true, J) -> {true, J};
        (false, J) ->
            case lists:nth(i + 1, M) of
                Row when lists:nth(J + 1, Row) =:= 1 ->
                    mark_visited(M, lists:replace(J, true, Visited), J);
                _ -> {false, Visited}
            end
    end, Visited, lists:seq(0, length(Visited) - 1)).