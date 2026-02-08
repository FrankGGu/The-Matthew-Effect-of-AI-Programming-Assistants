-module(second_minimum_time).
-export([second_minimum_time/4]).

second_minimum_time(N, Edges, Time, Change) ->
  Graph = create_graph(N, Edges),
  shortest_paths(N, Graph, Time, Change).

create_graph(N, Edges) ->
  lists:foldl(
    fun([U, V], Acc) ->
      Acc#{U => lists:append(maps:get(U, Acc, []), [V]),
            V => lists:append(maps:get(V, Acc, []), [U])}
    end,
    maps:new(),
    Edges
  ).

shortest_paths(N, Graph, Time, Change) ->
  Q = queue:new(),
  Dist = array:new({1, N}, {distance, infinity, 0}),
  array:set(1, Dist, {distance, 0, 1}),
  queue:in({1, 0}, Q),

  traverse(N, Graph, Time, Change, Q, Dist).

traverse(N, Graph, Time, Change, Q, Dist) ->
  case queue:out(Q) of
    {empty, _} ->
      array:get(N, Dist, {distance, infinity, 0});
    {{value, {Node, CurrentTime}}, NewQ} ->
      Neighbors = maps:get(Node, Graph, []),
      lists:foldl(
        fun(Neighbor, {NewQ1, NewDist}) ->
          {NextTime, SignalTime} = next_time(CurrentTime, Time, Change),
          NeighborDistance = array:get(Neighbor, NewDist, {distance, infinity, 0}),
          case NeighborDistance of
            {distance, infinity, _} ->
              array:set(Neighbor, NewDist, {distance, SignalTime, 1}),
              {queue:in({Neighbor, SignalTime}, NewQ1), NewDist};
            {distance, D, Count} when D > SignalTime ->
              array:set(Neighbor, NewDist, {distance, SignalTime, 1}),
              {queue:in({Neighbor, SignalTime}, NewQ1), NewDist};
            {distance, D, Count} when D == SignalTime ->
              {NewQ1, NewDist};
            {distance, D, Count} when D < SignalTime and Count < 2 ->
              array:set(Neighbor, NewDist, {distance, D, Count + 1}),
               {queue:in({Neighbor, SignalTime}, NewQ1), NewDist};
            _ ->
              {NewQ1, NewDist}
          end
        end,
        {NewQ, Dist},
        Neighbors
      ),
      traverse(N, Graph, Time, Change, NewQ, Dist)
  end.

next_time(CurrentTime, Time, Change) ->
  CycleTime = CurrentTime div Change,
  if (CycleTime rem 2) == 1 ->
    SignalTime = ((CycleTime + 1) * Change) + Time;
  else
    SignalTime = CurrentTime + Time;
  end,
  {SignalTime, SignalTime}.

-ifdef(TEST).
-include_lib("eunit/include/eunit.hrl").

second_minimum_time_test() ->
  [
    ?assertEqual(13, second_minimum_time(5, [[1,2],[1,3],[1,4],[3,4],[4,5]], 3, 5)),
    ?assertEqual(11, second_minimum_time(2, [[1,2]], 3, 2))
  ].
-endif.