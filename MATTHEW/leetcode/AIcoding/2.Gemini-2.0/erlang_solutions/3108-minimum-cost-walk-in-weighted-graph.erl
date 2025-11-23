-module(min_cost_walk).
-export([min_cost_walk/2]).

min_cost_walk(N, Edges) ->
  Graph = build_graph(Edges),
  dijkstra(Graph, 1, N, N).

build_graph(Edges) ->
  lists:foldl(
    fun([U, V, W], Acc) ->
      Acc1 = maps:update_with(U, fun(L) -> [{V, W} | L] end, [{V, W}], Acc),
      maps:update_with(V, fun(L) -> [{U, W} | L] end, [{U, W}], Acc1)
    end,
    #{},
    Edges
  ).

dijkstra(Graph, Start, End, N) ->
  Dist = maps:from_list([{I, infinity} || I <- lists:seq(1, N)]),
  Dist1 = maps:put(Start, 0, Dist),
  Q = orddict:new(),
  Q1 = orddict:store(0, Start, Q),

  dijkstra_helper(Graph, Q1, Dist1, End).

dijkstra_helper(Graph, Q, Dist, End) ->
  case orddict:fetch(Q) of
    error ->
      infinity;
    {ok, {D, U}, Q2} ->
      if U == End ->
        D;
      true ->
        Neighbors = maps:get(U, Graph, []),
        dijkstra_helper(Graph, update_queue(Graph, Q2, Dist, U, Neighbors), Dist, End)
      end
  end.

update_queue(Graph, Q, Dist, U, Neighbors) ->
  lists:foldl(
    fun({V, W}, Acc) ->
      DV = maps:get(V, Dist),
      DU = maps:get(U, Dist);
      if DU + W < DV ->
        Dist1 = maps:put(V, DU + W, Dist),
        orddict:store(DU + W, V, Acc);
      true ->
        Acc
      end
    end,
    Q,
    Neighbors
  ).

infinity() ->
  1 bsl 60.