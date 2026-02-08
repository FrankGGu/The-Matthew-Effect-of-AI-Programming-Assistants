-module(solution).
-export([countUnreachablePairs/2]).

countUnreachablePairs(N, Edges) ->
    Adj = build_adj_list(N, Edges),

    Visited = gb_sets:new(),
    {ComponentSizes, _FinalVisited} = find_component_sizes_loop(N, Adj, Visited, 0, []),

    SumOfSqSizes = lists:foldl(fun(Size, Acc) -> Acc + Size*Size end, 0, ComponentSizes),

    (N * N - SumOfSqSizes) div 2.

build_adj_list(N, Edges) ->
    InitialAdj = maps:from_list([{I, []} || I <- lists:seq(0, N-1)]),
    lists:foldl(
        fun([U, V], Acc) ->
            Acc1 = maps:update_with(U, fun(List) -> [V | List] end, [V], Acc),
            maps:update_with(V, fun(List) -> [U | List] end, [U], Acc1)
        end,
        InitialAdj,
        Edges
    ).

find_component_sizes_loop(N, Adj, Visited, CurrentNode, AccSizes) when CurrentNode < N ->
    case gb_sets:is_member(CurrentNode, Visited) of
        true ->
            find_component_sizes_loop(N, Adj, Visited, CurrentNode + 1, AccSizes);
        false ->
            {ComponentSize, NewVisited} = bfs(CurrentNode, Adj, Visited),
            find_component_sizes_loop(N, Adj, NewVisited, CurrentNode + 1, [ComponentSize | AccSizes])
    end;
find_component_sizes_loop(_N, _Adj, Visited, _CurrentNode, AccSizes) ->
    {AccSizes, Visited}.

bfs(StartNode, Adj, InitialVisited) ->
    Queue = [StartNode],
    Visited = gb_sets:add(StartNode, InitialVisited),
    bfs_internal(Queue, Adj, Visited, 1).

bfs_internal([], _Adj, Visited, Size) ->
    {Size, Visited};
bfs_internal([Node | RestQueue], Adj, Visited, Size) ->
    Neighbors = maps:get(Node, Adj, []),

    {NewQueue, NewVisited, NewSize} = lists:foldl(
        fun(Neighbor, {AccQueue, AccVisited, AccSize}) ->
            case gb_sets:is_member(Neighbor, AccVisited) of
                true -> {AccQueue, AccVisited, AccSize};
                false -> { AccQueue ++ [Neighbor], gb_sets:add(Neighbor, AccVisited), AccSize + 1 }
            end
        end,
        {[], Visited, Size},
        Neighbors
    ),

    bfs_internal(RestQueue ++ NewQueue, Adj, NewVisited, NewSize).