-module(number_of_ways).
-export([count_paths/2]).

count_paths(n, roads) ->
  {dist, ways} = dijkstra(n, roads),
  lists:nth(n, ways).

dijkstra(n, roads) ->
  graph = build_graph(roads),
  dist = lists:duplicate(n, infinity),
  ways = lists:duplicate(n, 0),
  dist_dict = dict:new(),
  dist_dict1 = dict:store(1, 0, dist_dict),
  dist_dict2 = dict:store(1, 1, dist_dict1),
  dijkstra_loop(n, graph, dist, ways, dist_dict2).

dijkstra_loop(n, graph, dist, ways, dist_dict) ->
  case dict:size(dist_dict) of
    0 ->
      {dist, ways};
    _ ->
      {Node, D} = find_min_node(dist_dict),
      dist1 = lists:nth(Node, dist),
      ways1 = lists:nth(Node, ways),

      case D =/= dist1 of
        true ->
          NewDistDict = dict:erase(Node, dist_dict),
          dijkstra_loop(n, graph, dist, ways, NewDistDict);
        false ->
          NewDistDict = dict:erase(Node, dist_dict),
          Neighbors = maps:get(Node, graph, []),
          {NewDist, NewWays, NewDistDict2} = update_neighbors(n, graph, Node, Neighbors, dist, ways, NewDistDict),
          dijkstra_loop(n, graph, NewDist, NewWays, NewDistDict2)
      end
  end.

update_neighbors(n, graph, Node, Neighbors, dist, ways, DistDict) ->
  lists:foldl(
    fun({Neighbor, Weight}, {AccDist, AccWays, AccDistDict}) ->
      DistNode = lists:nth(Node, AccDist),
      DistNeighbor = lists:nth(Neighbor, AccDist),
      NewDist = DistNode + Weight,
      case NewDist < DistNeighbor of
        true ->
          NewAccDist = lists:nth(Neighbor, lists:replace_nth(Neighbor - 1, NewDist, AccDist));
          NewAccWays = lists:nth(Neighbor, lists:replace_nth(Neighbor - 1, lists:nth(Node, AccWays), AccWays));
          case dict:is_key(Neighbor, AccDistDict) of
            true ->
              NewAccDistDict1 = dict:store(Neighbor, NewDist, AccDistDict);
              {NewAccDist, NewAccWays, NewAccDistDict1};
            false ->
              NewAccDistDict1 = dict:store(Neighbor, NewDist, AccDistDict);
              NewAccDistDict2 = dict:store(Neighbor, lists:nth(Node, AccWays), NewAccDistDict1);
              {NewAccDist, NewAccWays, NewAccDistDict2};
          end;
        false ->
          case NewDist =:= DistNeighbor of
            true ->
              NewAccWays = lists:nth(Neighbor, lists:replace_nth(Neighbor - 1, (lists:nth(Neighbor, AccWays) + lists:nth(Node, AccWays)) rem 1000000007, AccWays));
              {AccDist, NewAccWays, AccDist};
            false ->
              {AccDist, AccWays, AccDist};
          end
      end
    end,
    {dist, ways, DistDict},
    Neighbors
  ).

find_min_node(DistDict) ->
  find_min_node_loop(dict:to_list(DistDict), infinity, undefined).

find_min_node_loop([], MinDist, MinNode) ->
  {MinNode, MinDist};
find_min_node_loop([{Node, Dist} | Rest], MinDistAcc, MinNodeAcc) ->
  case Dist < MinDistAcc of
    true ->
      find_min_node_loop(Rest, Dist, Node);
    false ->
      find_min_node_loop(Rest, MinDistAcc, MinNodeAcc)
  end.

build_graph(Roads) ->
  lists:foldl(
    fun(
      [U, V, Time],
      GraphAcc
    ) ->
      GraphAcc1 = maps:update_with(U, fun(Neighbors) -> [{V, Time} | Neighbors] end, [{V, Time}], GraphAcc);
      maps:update_with(V, fun(Neighbors) -> [{U, Time} | Neighbors] end, [{U, Time}], GraphAcc1)
    end,
    maps:new(),
    Roads
  ).