-module(properties_graph).
-export([solve/1]).

solve(Edges) ->
  Nodes = lists:usort(lists:flatten([A, B] || {A, B} <- Edges)),
  Graph = build_graph(Edges),
  {MaxComponentSize, _MaxComponent} = find_largest_component(Graph, Nodes),
  MaxComponentSize.

build_graph(Edges) ->
  lists:foldl(
    fun({A, B}, Acc) ->
      Acc#{
        A => lists:usort(lists:append(maps:get(A, Acc, []), [B])),
        B => lists:usort(lists:append(maps:get(B, Acc, []), [A]))
      }
    end,
    #{},
    Edges
  ).

find_largest_component(Graph, Nodes) ->
  find_largest_component(Graph, Nodes, [], 0, []).

find_largest_component(_Graph, [], _Visited, MaxSize, MaxComponent) ->
  {MaxSize, MaxComponent};
find_largest_component(Graph, [Node | Rest], Visited, MaxSize, MaxComponent) ->
  case lists:member(Node, Visited) of
    true ->
      find_largest_component(Graph, Rest, Visited, MaxSize, MaxComponent);
    false ->
      {Component, NewVisited} = dfs(Node, Graph, Visited, [Node]),
      ComponentSize = length(Component),
      case ComponentSize > MaxSize of
        true ->
          find_largest_component(Graph, Rest, NewVisited, ComponentSize, Component);
        false ->
          find_largest_component(Graph, Rest, NewVisited, MaxSize, MaxComponent)
      end
  end.

dfs(Node, Graph, Visited, Component) ->
  Neighbors = maps:get(Node, Graph, []),
  lists:foldl(
    fun(Neighbor, {AccComponent, AccVisited}) ->
      case lists:member(Neighbor, AccVisited) of
        true ->
          {AccComponent, AccVisited};
        false ->
          {NewComponent, NewVisited} = dfs(Neighbor, Graph, AccVisited, [Neighbor | AccComponent]),
          {NewComponent, NewVisited}
      end
    end,
    {Component, [Node | Visited]},
    Neighbors
  ).