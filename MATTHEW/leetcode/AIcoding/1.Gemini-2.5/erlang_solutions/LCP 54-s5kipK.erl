-module(solution).
-export([solve/3]).

solve(N, Edges, StartNode) ->
    Adj = lists:foldl(
        fun([U, V], Acc) ->
            Acc1 = maps:update_with(U, fun(L) -> [V | L] end, [V], Acc),
            maps:update_with(V, fun(L) -> [U | L] end, [U], Acc1)
        end,
        maps:new(),
        Edges
    ),

    Distances = maps:put(StartNode, 0,
        maps:from_list([{I, infinity} || I <- lists:seq(0, N-1)])
    ),

    Q = queue:in({StartNode, 0}, queue:new()),

    bfs(Q, Adj, Distances).

bfs(Q, Adj, Distances) ->
    case queue:out(Q) of
        {{value, {U, DistU}}, RestQ} ->
            Neighbors = maps:get(U, Adj, []),
            {NewQ, NewDistances} = lists:foldl(
                fun(V, {CurrentQ, CurrentDistances}) ->
                    case maps:get(V, CurrentDistances) of
                        infinity ->
                            NewDistV = DistU + 1,
                            {queue:in({V, NewDistV}, CurrentQ), maps:put(V, NewDistV, CurrentDistances)};
                        _ ->
                            {CurrentQ, CurrentDistances}
                    end
                end,
                {RestQ, Distances},
                Neighbors
            ),
            bfs(NewQ, Adj, NewDistances);
        {empty, _} ->
            Distances
    end.