-module(number_of_ways_to_assign_edge_weights_ii).
-export([number_of_ways_to_assign_edge_weights_ii/1]).

number_of_ways_to_assign_edge_weights_ii(Input) ->
    Edges = maps:get(edges, Input),
    N = maps:get(n, Input),
    Source = maps:get(source, Input),
    Destination = maps:get(destination, Input),

    solve(N, Source, Destination, Edges).

solve(N, Source, Destination, Edges) ->
    Graph = build_graph(N, Edges),
    {Dist, Prev} = dijkstra(Graph, Source, Destination, N),

    PathEdges = get_path_edges(Destination, Prev, Graph),

    TotalEdges = length(Edges),
    PathEdgeCount = length(PathEdges),

    UnknownEdges = TotalEdges - PathEdgeCount,

    if Dist == infinity then
        0
    else
        NumWays = count_ways(PathEdgeCount, UnknownEdges)
    end.

build_graph(N, Edges) ->
    Graph = lists:foldl(
        fun([U, V, W], Acc) ->
            Acc1 = maps:update_with(U, fun(Neighbors) -> lists:append(Neighbors, [{V, W}]) end, [{V, W}], Acc),
            maps:update_with(V, fun(Neighbors) -> lists:append(Neighbors, [{U, W}]) end, [{U, W}], Acc1)
        end,
        maps:from_list([{I, []} || I <- lists:seq(1, N)]),
        Edges
    ).

dijkstra(Graph, Source, Destination, N) ->
    Dist = maps:from_list([{I, infinity} || I <- lists:seq(1, N)]),
    Dist1 = maps:put(Source, 0, Dist),
    Prev = maps:from_list([{I, null} || I <- lists:seq(1, N)]),
    Q = gb_sets:empty(),
    Q1 = gb_sets:add(Source, Q),

    dijkstra_loop(Graph, Dist1, Prev, Q1, Destination, N).

dijkstra_loop(Graph, Dist, Prev, Q, Destination, _N) when gb_sets:is_empty(Q) ->
    {Dist, Prev};
dijkstra_loop(Graph, Dist, Prev, Q, Destination, N) ->
    {U, Q2} = gb_sets:take_smallest(Q),

    Neighbors = maps:get(U, Graph, []),

    {Dist2, Prev2, Q3} = lists:foldl(
        fun({V, W}, {DistAcc, PrevAcc, QAcc}) ->
            if maps:get(U, DistAcc) + W < maps:get(V, DistAcc) then
                DistNew = maps:put(V, maps:get(U, DistAcc) + W, DistAcc),
                PrevNew = maps:put(V, U, PrevAcc),
                QNew = gb_sets:add(V, QAcc),
                {DistNew, PrevNew, QNew}
            else
                {DistAcc, PrevAcc, QAcc}
            end
        end,
        {Dist, Prev, Q2},
        Neighbors
    ),

    dijkstra_loop(Graph, Dist2, Prev2, Q3, Destination, N).

get_path_edges(Destination, Prev, Graph) ->
    get_path_edges_helper(Destination, Prev, Graph, []).

get_path_edges_helper(Source, _Prev, _Graph, Acc) when Source == null ->
    Acc;
get_path_edges_helper(Destination, Prev, Graph, Acc) ->
    Previous = maps:get(Destination, Prev),
    if Previous == null then
      Acc
    else
      Edges = maps:get(Previous, Graph),
      Weight = lists:keyfind(Destination, 1, Edges),
      get_path_edges_helper(Previous, Prev, Graph, [ {Previous, Destination, element(2,Weight)} | Acc])
    end.

count_ways(PathEdgeCount, UnknownEdges) ->
    (count_ways_helper(PathEdgeCount) * power(3, UnknownEdges)) rem 1000000007.

count_ways_helper(PathEdgeCount) ->
    case PathEdgeCount of
        0 -> 1;
        1 -> 2;
        _ -> 
            Res = (power(3,PathEdgeCount) - 1) rem 1000000007,
            if Res < 0 then
              Res + 1000000007
            else
              Res
            end
    end.

power(Base, Exp) ->
  power_helper(Base, Exp, 1).

power_helper(Base, 0, Acc) ->
  Acc rem 1000000007;
power_helper(Base, Exp, Acc) ->
  if Exp rem 2 == 0 then
    power_helper((Base * Base) rem 1000000007, Exp div 2, Acc)
  else
    power_helper(Base, Exp - 1, (Acc * Base) rem 1000000007)
  end.