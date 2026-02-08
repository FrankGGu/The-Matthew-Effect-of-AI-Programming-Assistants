-module(largest_color_value_in_a_directed_graph).
-export([largest_path_value/3]).

largest_path_value(N, EdgeList, Color) ->
    Graph = build_graph(N, EdgeList),
    Visited = lists:duplicate(N, false),
    MaxColors = lists:duplicate(N, 0),
    {MaxColors, _} = dfs(0, Graph, Visited, MaxColors, Color),
    lists:foldl(fun(X, Acc) -> max(X, Acc) end, 0, MaxColors).

build_graph(N, EdgeList) ->
    lists:foldl(fun({U, V}, Acc) ->
        UInt = U + 1,
        VInt = V + 1,
        case dict:is_key(UInt, Acc) of
            true -> dict:update(UInt, fun(Val) -> [VInt | Val] end, Acc);
            false -> dict:store(UInt, [VInt], Acc)
        end
    end, dict:new(), EdgeList).

dfs(Node, Graph, Visited, MaxColors, Color) ->
    case lists:nth(Node + 1, Visited) of
        true -> {MaxColors, true};
        false ->
            Visited2 = lists:sublist(Visited, Node) ++ [true] ++ lists:nthtail(Node + 1, Visited),
            CurrentColor = lists:nth(Node + 1, Color),
            Counts = lists:duplicate(100, 0),
            Counts2 = lists:sublist(Counts, CurrentColor) ++ [1] ++ lists:nthtail(CurrentColor, Counts),
            {NewCounts, _} = lists:foldl(fun(Child, {AccCounts, _}) ->
                case dict:is_key(Child, Graph) of
                    true ->
                    {ChildCounts, _} = dfs(Child, Graph, Visited2, MaxColors, Color),
                    Merged = lists:zipwith(fun(A, B) -> max(A, B) end, AccCounts, ChildCounts),
                    {Merged, true};
                    false -> {AccCounts, true}
                end
            end, {Counts2, false}, dict:fetch(Node + 1, Graph, [])),
            NewMaxColors = lists:sublist(MaxColors, Node) ++ [lists:max(NewCounts)] ++ lists:nthtail(Node + 1, MaxColors),
            {NewMaxColors, true}
    end.