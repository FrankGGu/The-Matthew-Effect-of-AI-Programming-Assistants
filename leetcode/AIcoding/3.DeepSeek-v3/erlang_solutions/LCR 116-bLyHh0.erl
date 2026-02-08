-spec find_circle_num(IsConnected :: [[integer()]]) -> integer().
find_circle_num(IsConnected) ->
    N = length(IsConnected),
    Visited = maps:new(),
    {Count, _} = lists:foldl(
        fun(I, {C, V}) ->
            case maps:is_key(I, V) of
                true -> {C, V};
                false -> 
                    NewV = dfs(I, IsConnected, V),
                    {C + 1, NewV}
            end
        end,
        {0, Visited},
        lists:seq(0, N - 1)
    ),
    Count.

dfs(Node, IsConnected, Visited) ->
    case maps:is_key(Node, Visited) of
        true -> Visited;
        false ->
            NewVisited = maps:put(Node, true, Visited),
            lists:foldl(
                fun(Neighbor, V) ->
                    case lists:nth(Node + 1, IsConnected) of
                        Row -> 
                            case lists:nth(Neighbor + 1, Row) of
                                1 -> dfs(Neighbor, IsConnected, V);
                                _ -> V
                            end
                    end
                end,
                NewVisited,
                lists:seq(0, length(IsConnected) - 1)
            )
    end.