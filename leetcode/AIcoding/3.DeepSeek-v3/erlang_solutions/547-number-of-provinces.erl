-spec find_circle_num(IsConnected :: [[integer()]]) -> integer().
find_circle_num(IsConnected) ->
    N = length(IsConnected),
    Visited = array:new([{size, N}, {fixed, true}, {default, false}]),
    Count = 0,
    dfs_all(IsConnected, Visited, 0, N, Count).

dfs_all(_, _, N, N, Count) -> Count;
dfs_all(IsConnected, Visited, I, N, Count) ->
    case array:get(I, Visited) of
        false ->
            NewVisited = dfs(IsConnected, Visited, I),
            dfs_all(IsConnected, NewVisited, I + 1, N, Count + 1);
        true ->
            dfs_all(IsConnected, Visited, I + 1, N, Count)
    end.

dfs(IsConnected, Visited, I) ->
    case array:get(I, Visited) of
        true -> Visited;
        false ->
            NewVisited = array:set(I, true, Visited),
            lists:foldl(fun(J, AccVisited) ->
                case lists:nth(J + 1, lists:nth(I + 1, IsConnected)) of
                    1 -> dfs(IsConnected, AccVisited, J);
                    _ -> AccVisited
                end
            end, NewVisited, lists:seq(0, length(IsConnected) - 1))
    end.