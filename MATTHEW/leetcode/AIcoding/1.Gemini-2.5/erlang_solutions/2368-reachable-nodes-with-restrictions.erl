-module(solution).
-export([reachable_nodes/3]).

reachable_nodes(_N, Edges, Restricted) ->
    RestrictedSet = sets:from_list(Restricted),

    % If node 0 is restricted, no nodes are reachable from it.
    if sets:is_element(0, RestrictedSet) ->
        0;
    true ->
        Adj = build_adj_list(Edges),

        % Initialize BFS
        Queue = queue:in(0, queue:new()),
        VisitedSet = sets:add_element(0, sets:new()),
        Count = 1,

        bfs_traverse(Adj, RestrictedSet, Queue, VisitedSet, Count)
    end.

build_adj_list(Edges) ->
    lists:foldl(
        fun([U, V], AccMap) ->
            AccMap1 = maps:update_with(U, fun(List) -> [V | List] end, [V], AccMap),
            maps:update_with(V, fun(List) -> [U | List] end, [U], AccMap1)
        end,
        #{},
        Edges
    ).

bfs_traverse(Adj, RestrictedSet, Queue, VisitedSet, Count) ->
    case queue:out(Queue) of
        {empty, _} ->
            Count;
        {value, CurrentNode, RestQueue} ->
            Neighbors = maps:get(CurrentNode, Adj, []),

            {NewQueue, NewVisitedSet, NewCount} = lists:foldl(
                fun(Neighbor, {Q, V, C}) ->
                    if
                        sets:is_element(Neighbor, RestrictedSet) orelse sets:is_element(Neighbor, V) ->
                            {Q, V, C};
                        true ->
                            {queue:in(Neighbor, Q), sets:add_element(Neighbor, V), C + 1}
                    end
                end,
                {RestQueue, VisitedSet, Count},
                Neighbors
            ),
            bfs_traverse(Adj, RestrictedSet, NewQueue, NewVisitedSet, NewCount)
    end.