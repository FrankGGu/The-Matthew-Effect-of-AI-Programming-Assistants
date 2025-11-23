-module(all_nodes_distance_k).
-export([distance_k/3]).

distance_k(Root, Target, K) ->
  Graph = build_graph(Root, []),
  start_bfs(Graph, Target, K).

build_graph(null, Graph) ->
  Graph;
build_graph({Val, Left, Right}, Graph) ->
  NewGraph =
    case Left of
      null -> Graph;
      {LeftVal, _, _} -> [{Val, LeftVal} | Graph]
    end,
  NewGraph2 =
    case Right of
      null -> NewGraph;
      {RightVal, _, _} -> [{Val, RightVal} | NewGraph]
    end,
  build_graph(Left, build_graph(Right, NewGraph2)).

start_bfs(Graph, {TargetVal, _, _}, K) ->
  start_bfs(Graph, TargetVal, K).

start_bfs(Graph, TargetVal, K) ->
  bfs(Graph, [TargetVal], K, [], []).

bfs(_Graph, [], _K, Visited, Acc) ->
  lists:reverse(Acc);
bfs(Graph, Queue, 0, Visited, Acc) ->
  NewAcc = Acc ++ Queue,
  lists:usort(NewAcc);
bfs(Graph, Queue, K, Visited, Acc) ->
  Neighbors = get_neighbors(Graph, Queue, Visited),
  bfs(Graph, Neighbors, K - 1, Visited ++ Queue, Acc).

get_neighbors(Graph, Queue, Visited) ->
  lists:flatten([get_neighbors_for_node(Graph, Node, Visited) || Node <- Queue]).

get_neighbors_for_node(Graph, Node, Visited) ->
  Neighbors = lists:foldl(
    fun({A, B}, Acc) ->
      case A of
        Node -> [B | Acc];
        _ ->
          case B of
            Node -> [A | Acc];
            _ -> Acc
          end
      end
    end,
    [],
    Graph
  ),
  lists:filter(fun(N) -> not lists:member(N, Visited) end, Neighbors).