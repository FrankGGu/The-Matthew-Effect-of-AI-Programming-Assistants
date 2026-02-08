-module(navigation_device).
-export([solve/1]).

solve(routes) ->
  graph_to_distance(create_graph(routes), 0, length(routes) + 1).

create_graph(Routes) ->
  lists:foldl(
    fun({From, To, Cost}, Graph) ->
      case maps:is_key(From, Graph) of
        true ->
          maps:update(From, maps:update(To, Cost, maps:get(From, Graph)), Graph);
        false ->
          maps:put(From, maps:from_list([{To, Cost}]), Graph)
      end
    end,
    maps:new(),
    Routes
  ).

graph_to_distance(Graph, Start, End) ->
  Dists = maps:from_list([{V, infinity} || V <- maps:keys(Graph) ++ [End]]),
  Dists1 = maps:update(Start, 0, Dists),
  Q = queue:from_list(maps:keys(Dists1)),
  dijkstra(Graph, Dists1, Q, End).

dijkstra(_Graph, Dists, Q, _End) when queue:is_empty(Q) ->
  maps:get(_End, Dists);
dijkstra(Graph, Dists, Q, End) ->
  {Value, Q1} = queue:out(Q),
  {ok, V} = Value,
  DistV = maps:get(V, Dists),
  case maps:is_key(V, Graph) of
    false ->
      dijkstra(Graph, Dists, Q1, End);
    true ->
      Neighbors = maps:get(V, Graph),
      lists:foldl(
        fun({Neighbor, Cost}, {NewDists, NewQ}) ->
          DistNeighbor = maps:get(Neighbor, NewDists),
          NewDist = DistV + Cost,
          case NewDist < DistNeighbor of
            true ->
              {maps:update(Neighbor, NewDist, NewDists), queue:in(Neighbor, NewQ)};
            false ->
              {NewDists, NewQ}
          end
        end,
        {Dists, Q1},
        maps:to_list(Neighbors)
      ) of
      {UpdatedDists, UpdatedQ} ->
        dijkstra(Graph, UpdatedDists, UpdatedQ, End)
  end.