-module(fast_bus).
-export([numBusesToDestination/3]).

numBusesToDestination(Routes, Source, Target) ->
  if Source =:= Target then
    0
  else
    graph(Routes, Graph),
    bfs(Graph, Source, Target)
  end.

graph(Routes, Graph) ->
  Stations = lists:foldl(fun(Route, Acc) -> lists:append(Route, Acc) end, [], Routes),
  UniqueStations = lists:usort(Stations),

  StationToIndex = lists:zip(UniqueStations, lists:seq(1, length(UniqueStations))),

  Size = length(UniqueStations),
  AdjList = lists:duplicate(Size + 1, []),

  NewRoutes = [ [lists:keyfind(S, 1, StationToIndex) || S <- Route] || Route <- Routes],

  NewAdjList = lists:foldl(
    fun(Route, Acc) ->
      lists:foldl(
        fun(Station1, Acc2) ->
          lists:foldl(
            fun(Station2, Acc3) ->
              if Station1 =/= Station2 then
                Acc3#{Station1 => lists:usort(Acc3[Station1] ++ [Station2])}
              else
                Acc3
              end
            , Acc2, Route)
        , Acc, Route)
    , maps:from_list([{I, []} || I <- lists:seq(1, Size)]), NewRoutes),

  {UniqueStations, NewAdjList}.

bfs({Stations, Graph}, Source, Target) ->
  {ok, StartIndex} = lists:keyfind(Source, 1, lists:zip(Stations, lists:seq(1, length(Stations)))),
  {ok, EndIndex} = lists:keyfind(Target, 1, lists:zip(Stations, lists:seq(1, length(Stations)))),

  Queue = queue:new(),
  Queue1 = queue:in({StartIndex, 0}, Queue),
  Visited = sets:new(),
  Visited1 = sets:add_element(StartIndex, Visited),

  bfs_helper(Graph, EndIndex, Queue1, Visited1).

bfs_helper(Graph, Target, Queue, Visited) ->
  case queue:is_empty(Queue) of
    true ->
      -1;
    false ->
      {{value, {Node, Distance}}, Queue2} = queue:out(Queue),
      if Node =:= Target then
        Distance
      else
        Neighbors = maps:get(Node, Graph, []),

        {NewQueue, NewVisited} = lists:foldl(
          fun(Neighbor, {QAcc, VAcc}) ->
            case sets:is_element(Neighbor, VAcc) of
              true ->
                {QAcc, VAcc};
              false ->
                QNew = queue:in({Neighbor, Distance + 1}, QAcc),
                VNew = sets:add_element(Neighbor, VAcc),
                {QNew, VNew}
            end
          , {Queue2, Visited}, Neighbors),

        bfs_helper(Graph, Target, NewQueue, NewVisited)
      end
  end.