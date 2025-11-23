-module(find_path).
-export([valid_path/3]).

valid_path(N, Edges, Start, End) ->
  Graph = create_graph(N, Edges),
  dfs(Start, End, Graph, []).

create_graph(N, Edges) ->
  create_graph(N, Edges, []).

create_graph(0, _, Acc) ->
  Acc;
create_graph(N, Edges, Acc) ->
  create_graph(N - 1, Edges, [{N - 1, get_neighbors(N - 1, Edges)} | Acc]).

get_neighbors(Node, Edges) ->
  get_neighbors(Node, Edges, []).

get_neighbors(_, [], Acc) ->
  Acc;
get_neighbors(Node, [[U, V] | Rest], Acc) ->
  case U =:= Node of
    true ->
      get_neighbors(Node, Rest, [V | Acc]);
    false ->
      case V =:= Node of
        true ->
          get_neighbors(Node, Rest, [U | Acc]);
        false ->
          get_neighbors(Node, Rest, Acc)
      end
  end.

dfs(Node, End, Graph, Visited) ->
  case Node =:= End of
    true ->
      true;
    false ->
      case lists:member(Node, Visited) of
        true ->
          false;
        false ->
          Neighbors = proplists:get_value(Node, Graph),
          lists:any(fun(Neighbor) -> dfs(Neighbor, End, Graph, [Node | Visited]) end, Neighbors)
      end
  end.