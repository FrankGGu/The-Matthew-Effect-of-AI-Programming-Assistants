-module(find_edges_in_shortest_paths).
-export([find_critical_and_pseudo_critical_edges/4]).

find_critical_and_pseudo_critical_edges(N, Edges, Source, Destination) ->
  {Dist, Paths} = shortest_paths(N, Edges, Source, Destination),
  Critical = [],
  PseudoCritical = [],
  lists:foreach(
    fun(Edge) ->
      [U, V, W] = Edge,
      OriginalIndex = lists:keyfind(Edge, 1, lists:zip(lists:seq(1, length(Edges)), Edges)),
      case OriginalIndex of
        false ->
          ok;
        {Index, _} ->
          {NewDist, _} = shortest_paths(N, lists:delete(Edge, Edges), Source, Destination),
          case NewDist of
            infinity ->
              Critical1 = [Index | Critical],
              Critical2 = lists:usort(Critical1),
              Critical = Critical2;
            Dist when Dist < NewDist ->
              Critical1 = [Index | Critical],
              Critical2 = lists:usort(Critical1),
              Critical = Critical2;
            _ ->
              {NewDistWithEdgeForced, _} = shortest_paths_with_forced_edge(N, Edges, Source, Destination, U, V),
              case NewDistWithEdgeForced of
                Dist ->
                  PseudoCritical1 = [Index | PseudoCritical],
                  PseudoCritical2 = lists:usort(PseudoCritical1),
                  PseudoCritical = PseudoCritical2;
                _ ->
                  ok
              end
          end
      end
    end,
    Edges
  ),
  {Critical, PseudoCritical}.

shortest_paths(N, Edges, Source, Destination) ->
  Graph = create_graph(N, Edges),
  DijkstraResult = dijkstra(Graph, Source, N),
  Dist = maps:get(Destination, DijkstraResult, infinity),
  Paths = find_paths(Graph, Source, Destination, DijkstraResult),
  {Dist, Paths}.

shortest_paths_with_forced_edge(N, Edges, Source, Destination, U, V) ->
  Graph = create_graph(N, Edges),
  DijkstraResult = dijkstra_with_forced_edge(Graph, Source, N, U, V),
  Dist = maps:get(Destination, DijkstraResult, infinity),
  Paths = find_paths(Graph, Source, Destination, DijkstraResult),
  {Dist, Paths}.

create_graph(N, Edges) ->
  create_graph(N, Edges, maps:new()).

create_graph(0, _, Graph) ->
  Graph;
create_graph(N, Edges, Graph) ->
  create_graph(N - 1, Edges, maps:put(N, [], Graph));

dijkstra(Graph, Source, N) ->
  dijkstra(Graph, Source, N, maps:new(), priority_queue:new()).

dijkstra(Graph, Source, N, Distances, Queue) ->
  dijkstra_init(Graph, Source, N, Distances, Queue).

dijkstra_init(Graph, Source, N, Distances, Queue) ->
  NewDistances = maps:put(Source, 0, Distances),
  NewQueue = priority_queue:insert(0, Source, Queue),
  dijkstra_loop(Graph, N, NewDistances, NewQueue).

dijkstra_loop(Graph, _, Distances, Queue) when priority_queue:is_empty(Queue) ->
  Distances;
dijkstra_loop(Graph, N, Distances, Queue) ->
  {_, U, NewQueue} = priority_queue:get_min(Queue),
  Neighbors = maps:get(U, Graph, []),
  dijkstra_relax(Graph, N, U, Neighbors, Distances, NewQueue).

dijkstra_relax(Graph, N, U, Neighbors, Distances, Queue) ->
  dijkstra_relax(Graph, N, U, Neighbors, Distances, Queue, []).

dijkstra_relax(Graph, N, U, [], Distances, Queue, Acc) ->
  dijkstra_loop(Graph, N, Distances, Queue);
dijkstra_relax(Graph, N, U, [{V, W} | Rest], Distances, Queue, Acc) ->
  DistU = maps:get(U, Distances, infinity),
  DistV = maps:get(V, Distances, infinity),
  if
    DistU + W < DistV ->
      NewDistances = maps:put(V, DistU + W, Distances),
      NewQueue = priority_queue:insert(DistU + W, V, priority_queue:delete(V, Queue)),
      dijkstra_relax(Graph, N, U, Rest, NewDistances, NewQueue, Acc);
    true ->
      dijkstra_relax(Graph, N, U, Rest, Distances, Queue, Acc)
  end.

dijkstra_with_forced_edge(Graph, Source, N, U, V) ->
  dijkstra_with_forced_edge(Graph, Source, N, U, V, maps:new(), priority_queue:new()).

dijkstra_with_forced_edge(Graph, Source, N, U, V, Distances, Queue) ->
  dijkstra_with_forced_edge_init(Graph, Source, N, U, V, Distances, Queue).

dijkstra_with_forced_edge_init(Graph, Source, N, U, V, Distances, Queue) ->
  NewDistances = maps:put(Source, 0, Distances),
  NewQueue = priority_queue:insert(0, Source, Queue),
  dijkstra_with_forced_edge_loop(Graph, N, U, V, NewDistances, NewQueue).

dijkstra_with_forced_edge_loop(Graph, _, U, V, Distances, Queue) when priority_queue:is_empty(Queue) ->
  Distances;
dijkstra_with_forced_edge_loop(Graph, N, U, V, Distances, Queue) ->
  {_, X, NewQueue} = priority_queue:get_min(Queue),
  Neighbors = maps:get(X, Graph, []),
  dijkstra_with_forced_edge_relax(Graph, N, U, V, X, Neighbors, Distances, NewQueue).

dijkstra_with_forced_edge_relax(Graph, N, U, V, X, Neighbors, Distances, Queue) ->
  dijkstra_with_forced_edge_relax(Graph, N, U, V, X, Neighbors, Distances, Queue, []).

dijkstra_with_forced_edge_relax(Graph, N, U, V, X, [], Distances, Queue, Acc) ->
  dijkstra_with_forced_edge_loop(Graph, N, U, V, Distances, Queue);
dijkstra_with_forced_edge_relax(Graph, N, U, V, X, [{Y, W} | Rest], Distances, Queue, Acc) ->
  DistX = maps:get(X, Distances, infinity),
  DistY = maps:get(Y, Distances, infinity),
  if
    DistX + W < DistY ->
      NewDistances = maps:put(Y, DistX + W, Distances),
      NewQueue = priority_queue:insert(DistX + W, Y, priority_queue:delete(Y, Queue)),
      dijkstra_with_forced_edge_relax(Graph, N, U, V, X, Rest, NewDistances, NewQueue, Acc);
    true ->
      dijkstra_with_forced_edge_relax(Graph, N, U, V, X, Rest, Distances, Queue, Acc)
  end.

find_paths(Graph, Source, Destination, Distances) ->
  find_paths(Graph, Source, Destination, Distances, [Destination], []).

find_paths(_, _, _, _, [], Acc) ->
  Acc;
find_paths(Graph, Source, Destination, Distances, [Current | Rest], Acc) ->
  DistCurrent = maps:get(Current, Distances, infinity),
  NewAcc =
    case Current == Source of
      true ->
        [[Current] | Acc];
      false ->
        Preds = find_predecessors(Graph, Current, Distances),
        NewPaths =
          lists:foldl(
            fun(Pred, Paths) ->