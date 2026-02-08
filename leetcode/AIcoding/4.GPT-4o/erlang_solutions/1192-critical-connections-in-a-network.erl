-module(solution).
-export([critical_connections/2]).

critical_connections(N, Connections) ->
    Graph = build_graph(N, Connections),
    Visited = lists:duplicate(N, false),
    Low = lists:duplicate(N, 0),
    Disc = lists:duplicate(N, 0),
    Time = [0],
    Result = [],
    dfs(Graph, 0, -1, Visited, Low, Disc, Time, Result),
    lists:filter(fun({X, Y}) -> X < Y end, Result).

build_graph(N, Connections) ->
    Graph = lists:foldl(fun({X, Y}, Acc) ->
        lists:keystore(X, X, [{X, []} | Acc]) ++ [{X, [Y | lists:keyfind(X, X, Acc)]}],
        lists:keystore(Y, Y, [{Y, []} | Acc]) ++ [{Y, [X | lists:keyfind(Y, Y, Acc)]}]
    end, [], Connections),
    lists:map(fun({K, V}) -> {K, lists:usort(V)} end, Graph).

dfs(Graph, Node, Parent, Visited, Low, Disc, Time, Result) ->
    Visited1 = lists:replace_element(Node, true, Visited),
    Disc1 = lists:replace_element(Node, hd(Time), Disc),
    Low1 = lists:replace_element(Node, hd(Time), Low),
    Time1 = [hd(Time) + 1],
    lists:foldl(fun(Neighbor, {Visited, Low, Disc, Time, Result}) ->
        case lists:keyfind(Neighbor, Neighbor, Visited) of
            false ->
                {Visited2, Low2, Disc2, Result2} = dfs(Graph, Neighbor, Node, Visited, Low1, Disc1, Time1, Result),
                Low3 = lists:min(Low2, Low1),
                Result3 = if Low2 > Disc1 -> [{Node, Neighbor} | Result2]; true -> Result2 end,
                {Visited2, Low3, Disc2, Result3};
            _ when Neighbor =/= Parent ->
                {Visited, lists:min(Low, Disc), Disc, Result}
        end
    end, {Visited1, Low1, Disc1, Result}, lists:keyfind(Node, Node, Graph)).