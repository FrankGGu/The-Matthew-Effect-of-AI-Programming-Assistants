-module(solution).
-export([count_unreachable_pairs/2]).

count_unreachable_pairs(N, Edges) ->
    Graph = build_graph(N, Edges),
    Sizes = bfs_sizes(Graph, N),
    Total = lists:sum(Sizes),
    lists:foldl(fun(Size, Acc) -> Acc + Size * (Total - Size) end, 0, Sizes) div 2.

build_graph(N, Edges) ->
    Graph = lists:foldl(fun({U, V}, Acc) -> 
        Acc1 = lists:keystore(U, U, [{U, []} | Acc]),
        Acc2 = lists:keystore(V, V, [{V, []} | Acc1]),
        lists:keystore(U, U, [{U, V :: lists:nth(2, lists:keyfind(U, U, Acc1))} | Acc1]),
        lists:keystore(V, V, [{V, U :: lists:nth(2, lists:keyfind(V, V, Acc1))} | Acc1])
    end, lists:duplicate(N, {0, []}), Edges),
    lists:map(fun({_, Neighbors}) -> Neighbors end, Graph).

bfs_sizes(Graph, N) ->
    bfs_sizes(Graph, N, lists:seq(1, N), [], []).

bfs_sizes(_, [], Sizes, Visited, Sizes) -> Sizes;
bfs_sizes(Graph, [Node | Rest], SizesAcc, Visited, Sizes) ->
    case lists:member(Node, Visited) of
        true -> bfs_sizes(Graph, Rest, SizesAcc, Visited, Sizes);
        false ->
            {Size, NewVisited} = bfs(Graph, Node, [], [Node]),
            bfs_sizes(Graph, Rest, [Size | SizesAcc], NewVisited, Sizes)
    end.

bfs(_, [], Size, Visited) -> {Size, Visited};
bfs(Graph, [Node | Rest], Size, Visited) ->
    Neighbors = lists:nth(2, lists:keyfind(Node, Node, Graph)),
    NewVisited = lists:filter(fun(X) -> not lists:member(X, Visited) end, Neighbors),
    bfs(Graph, Rest ++ NewVisited, Size + length(NewVisited), Visited ++ NewVisited).