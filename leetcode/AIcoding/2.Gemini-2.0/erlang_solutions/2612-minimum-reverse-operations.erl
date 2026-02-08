-module(minimum_reverse_operations).
-export([minimum_reverse_operations/3]).

minimum_reverse_operations(N, P, Banned) ->
  BannedSet = sets:from_list(Banned),
  Dist = lists:duplicate(N, -1),
  Dist = lists:replace(P, 0, Dist),
  Queue = queue:from_list([P]),
  Visited = sets:new(),
  Visited = sets:add_element(P, Visited),

  minimum_reverse_operations_helper(N, BannedSet, Dist, Queue, Visited).

minimum_reverse_operations_helper(N, BannedSet, Dist, Queue, Visited) ->
  case queue:is_empty(Queue) of
    true ->
      Dist;
    false ->
      {Value, NewQueue} = queue:out(Queue),
      {Value, NewQueue,
       NewVisited,
       NewDist} = process_neighbors(N, Value, queue:len(Queue),
                                   BannedSet, Dist,
                                   NewQueue, Visited),
      minimum_reverse_operations_helper(N, BannedSet, NewDist, NewQueue, NewVisited)
  end.

process_neighbors(N, Position, Distance, BannedSet, Dist, Queue, Visited) ->
  {NewQueue, NewVisited, NewDist} =
    lists:foldl(
      fun(K, {AccQueue, AccVisited, AccDist}) ->
          L = Position - K + 1,
          R = Position + K - 1,

          case (L >= 0 and R < N) of
            true ->
              Left = max(0, Position - (K - 1)),
              Right = min(N - 1, Position + (K - 1)),
              NewPos = Left + Right - Position,
              case (sets:is_element(NewPos, BannedSet) or sets:is_element(NewPos, AccVisited) or lists:nth(NewPos + 1, AccDist) /= -1) of
                true ->
                  {AccQueue, AccVisited, AccDist};
                false ->
                  NewAccDist = lists:replace(NewPos, Distance + 1, AccDist),
                  {queue:in(NewPos, AccQueue), sets:add_element(NewPos, AccVisited), NewAccDist}
              end;
            false ->
              {AccQueue, AccVisited, AccDist}
          end
      end,
      {Queue, Visited, Dist},
      lists:seq(1, N)
    ),
  {NewQueue, NewVisited, NewDist}.