-module(bus_routes).
-export([num_buses_to_destination/3]).

num_buses_to_destination(Routes, Source, Target) ->
  case Source =:= Target of
    true -> 0;
    false ->
      Graph = build_graph(Routes),
      bfs(Graph, Source, Target, Routes)
  end.

build_graph(Routes) ->
  {_, Graph} = lists:foldl(
    fun(Route, {Index, Acc}) ->
      NewAcc = lists:foldl(
        fun(Stop1, Acc1) ->
          lists:foldl(
            fun(Stop2, Acc2) ->
              case Stop1 =:= Stop2 of
                true -> Acc2;
                false ->
                  case maps:is_key(Stop1, Acc2) of
                    true ->
                      case lists:member(Stop2, maps:get(Stop1, Acc2)) of
                        true -> Acc2;
                        false ->
                          maps:update(Stop1, [Stop2 | maps:get(Stop1, Acc2)], Acc2)
                      end;
                    false ->
                      maps:put(Stop1, [Stop2], Acc2)
                  end
              end
            end,
            Acc1,
            Route
          )
        end,
        Acc,
        Route
      ),
      {Index + 1, NewAcc}
    end,
    {0, maps:new()},
    Routes
  ),
  Graph.

bfs(Graph, Source, Target, Routes) ->
  Queue = queue:new(),
  Queue1 = queue:in(Source, Queue),
  Visited = sets:new(),
  Visited1 = sets:add_element(Source, Visited),
  bfs_helper(Graph, Target, Queue1, Visited1, Routes, 0).

bfs_helper(Graph, Target, Queue, Visited, Routes, Buses) ->
  case queue:is_empty(Queue) of
    true -> -1;
    false ->
      {{value, Current}, Queue1} = queue:out(Queue),
      case Current =:= Target of
        true -> Buses;
        false ->
          Neighbors = get_neighbors(Graph, Current),
          {NewQueue, NewVisited, NewBuses} = lists:foldl(
            fun(Neighbor, {Q, V, B}) ->
              case sets:is_element(Neighbor, V) of
                true -> {Q, V, B};
                false ->
                  NewQ = queue:in(Neighbor, Q),
                  NewV = sets:add_element(Neighbor, V),
                  {NewQ, NewV, B}
              end
            end,
            {Queue1, Visited, Buses},
            Neighbors
          ),
          bfs_helper(Graph, Target, NewQueue, NewVisited, Routes, Buses + 1)
      end
  end.

get_neighbors(Graph, Stop) ->
  case maps:is_key(Stop, Graph) of
    true -> maps:get(Stop, Graph);
    false -> []
  end.