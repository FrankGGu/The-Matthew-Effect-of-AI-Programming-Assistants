-module(path_existence).
-export([solve/2]).

solve(N, Edges) ->
  fun(Queries) ->
    solve_queries(N, Edges, Queries)
  end.

solve_queries(N, Edges, Queries) ->
  Graph = build_graph(N, Edges),
  [has_path(Graph, Start, End, []) || {Start, End} <- Queries].

build_graph(N, Edges) ->
  lists:foldl(
    fun({U, V}, Graph) ->
      add_edge(Graph, U, V)
    end,
    create_empty_graph(N),
    Edges
  ).

create_empty_graph(N) ->
  lists:zip(lists:seq(1, N), lists:duplicate(N, [])).

add_edge(Graph, U, V) ->
  update_graph(Graph, U, V).

update_graph(Graph, U, V) ->
  lists:map(
    fun({Node, Neighbors}) ->
      case Node of
        U ->
          {Node, lists:sort(lists:union(Neighbors, [V]))};
        _ ->
          {Node, Neighbors}
      end
    end,
    Graph
  ).

has_path(Graph, Start, End, Visited) ->
  Start =:= End orelse
  case lists:member(Start, Visited) of
    true ->
      false;
    false ->
      Neighbors = get_neighbors(Graph, Start),
      lists:any(
        fun(Neighbor) ->
          has_path(Graph, Neighbor, End, [Start | Visited])
        end,
        Neighbors
      )
  end.

get_neighbors(Graph, Node) ->
  case lists:keyfind(Node, 1, Graph) of
    {_, Neighbors} ->
      Neighbors;
    false ->
      []
  end.