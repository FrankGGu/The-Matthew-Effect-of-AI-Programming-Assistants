-module(reorder_routes).
-export([min_reorder/2]).

min_reorder(N, Connections) ->
  Graph = create_graph(Connections),
  visited(N, Graph).

create_graph(Connections) ->
  create_graph(Connections, #{}, #{}).

create_graph([], Fwd, Rev) ->
  {Fwd, Rev};
create_graph([[U, V] | Rest], Fwd, Rev) ->
  NewFwd = maps:update(U, [V | maps:get(U, Fwd, [])], Fwd),
  NewRev = maps:update(V, [U | maps:get(V, Rev, [])], Rev),
  create_graph(Rest, NewFwd, NewRev).

visited(N, {Fwd, Rev}) ->
  visited(0, Fwd, Rev, [], 0).

visited(Node, Fwd, Rev, Visited, Count) ->
  NewVisited = [Node | Visited],
  Neighbors = get_neighbors(Node, Fwd, Rev),
  NextNodes = [Neighbor || Neighbor <- Neighbors, not lists:member(Neighbor, Visited)],
  NewCount = Count + count_reorder(Node, Neighbors, Fwd),

  visited_all(NextNodes, Fwd, Rev, NewVisited, NewCount).

visited_all([], _Fwd, _Rev, _Visited, Count) ->
  Count;
visited_all([Next | Rest], Fwd, Rev, Visited, Count) ->
  visited_all(Rest, Fwd, Rev, [Next | Visited], visited(Next, Fwd, Rev, Visited, Count)).

get_neighbors(Node, Fwd, Rev) ->
  lists:flatten([maps:get(Node, Fwd, []), maps:get(Node, Rev, [])]).

count_reorder(Node, Neighbors, Fwd) ->
  count_reorder(Node, Neighbors, Fwd, 0).

count_reorder(_, [], _Fwd, Count) ->
  Count;
count_reorder(Node, [Neighbor | Rest], Fwd, Count) ->
  case maps:is_key(Node, Fwd) andalso lists:member(Neighbor, maps:get(Node, Fwd, [])) of
    true ->
      count_reorder(Node, Rest, Fwd, Count + 1);
    false ->
      count_reorder(Node, Rest, Fwd, Count)
  end.