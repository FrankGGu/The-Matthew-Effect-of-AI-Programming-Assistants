-module(shortest_cycle).
-export([solve/1]).

solve(NGraphs) ->
  [shortest_cycle(G) || G <- NGraphs].

shortest_cycle(Graph) ->
  shortest_cycle(Graph, 10000000).

shortest_cycle(Graph, MinCycle) ->
  lists:foldl(
    fun(Node, Acc) ->
      MinCycle1 = bfs(Graph, Node, Acc),
      min(MinCycle1, Acc)
    end,
    MinCycle,
    lists:seq(1, length(Graph))
  ).

bfs(Graph, StartNode, MinCycle) ->
  bfs(Graph, StartNode, [], [{StartNode, 0}], MinCycle).

bfs(_Graph, _StartNode, _Visited, [], MinCycle) ->
  MinCycle;
bfs(Graph, StartNode, Visited, [{Node, Dist} | Queue], MinCycle) ->
  Neighbors = lists:nth(Node, Graph),
  lists:foldl(
    fun(Neighbor, Acc) ->
      case lists:member(Neighbor, Visited) of
        true ->
          case Neighbor == StartNode of
            true ->
              min(Acc, Dist + 1);
            false ->
              Acc
          end;
        false ->
          case lists:member(Neighbor, [X || {X, _} <- Queue]) of
            true ->
              Acc;
            false ->
              min(Acc, bfs(Graph, StartNode, [Node | Visited], Queue ++ [{Neighbor, Dist + 1}], Acc))
          end
      end
    end,
    MinCycle,
    Neighbors
  ).