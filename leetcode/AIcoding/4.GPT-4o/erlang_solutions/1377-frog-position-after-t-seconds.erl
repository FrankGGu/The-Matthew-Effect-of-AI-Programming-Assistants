-module(solution).
-export([frog_position/3]).

frog_position(N, edges, T) ->
    Graph = build_graph(N, edges),
    frog_position_helper(Graph, 1, T, 1).

frog_position_helper(Graph, Current, 0, _) ->
    Current;
frog_position_helper(Graph, Current, T, Parent) ->
    Neighbors = maps:get(Current, Graph, []),
    Count = length(Neighbors),
    if
        Count == 0 orelse (Count == 1 andalso hd(Neighbors) =:= Parent) ->
            Current;
        true ->
            NewT = T - 1,
            NewPosition = hd(Neighbors),
            frog_position_helper(Graph, NewPosition, NewT, Current)
    end.

build_graph(N, Edges) ->
    lists:foldl(fun({A, B}, Acc) ->
        Acc1 = maps:update_with(A, fun(L) -> [B | L] end, [B], Acc),
        maps:update_with(B, fun(L) -> [A | L] end, [A], Acc1)
    end, maps:new(), Edges).