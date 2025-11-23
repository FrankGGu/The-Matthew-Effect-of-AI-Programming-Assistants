-module(time_taken_to_mark_all_nodes).
-export([time_taken_to_mark_all_nodes/2]).

time_taken_to_mark_all_nodes(N, Edges) ->
  Graph = create_graph(N, Edges),
  time_taken_to_mark_all_nodes_helper(1, N, Graph, [], 0, []).

time_taken_to_mark_all_nodes_helper(Current, N, Graph, Marked, Time, Result) ->
  case length(Marked) of
    N ->
      lists:reverse(Result);
    _ ->
      NextMarked = mark_node(Current, Graph, Marked),
      case NextMarked =/= Marked of
        true ->
          time_taken_to_mark_all_nodes_helper(1, N, Graph, NextMarked, Time + 1, [Time+1|Result]);
        false ->
          time_taken_to_mark_all_nodes_helper(Current + 1, N, Graph, Marked, Time, Result)
      end
  end.

mark_node(Node, Graph, Marked) ->
  case lists:member(Node, Marked) of
    true ->
      Marked;
    false ->
      case is_markable(Node, Graph, Marked) of
        true ->
          lists:sort(Marked ++ [Node]);
        false ->
          Marked
      end
  end.

is_markable(Node, Graph, Marked) ->
  case maps:is_key(Node, Graph) of
    true ->
      Neighbors = maps:get(Node, Graph),
      AllMarked = lists:all(fun(N) -> lists:member(N, Marked) end, Neighbors),
      AllMarked;
    false ->
      true
  end.

create_graph(N, Edges) ->
  lists:foldl(fun({U, V}, Acc) ->
                  Acc1 = update_graph(U, V, Acc),
                  update_graph(V, U, Acc1)
              end, #{}, Edges).

update_graph(Node, Neighbor, Graph) ->
  case maps:is_key(Node, Graph) of
    true ->
      Neighbors = maps:get(Node, Graph),
      maps:put(Node, lists:sort(lists:usort(Neighbors ++ [Neighbor])), Graph);
    false ->
      maps:put(Node, [Neighbor], Graph)
  end.