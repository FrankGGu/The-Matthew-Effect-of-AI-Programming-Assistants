-module(find_closest_node).
-export([closestMeetingNode/3]).

closestMeetingNode(Edges, Node1, Node2) ->
  N = length(Edges),
  Dist1 = array:new([N], {fixed, infinity}),
  Dist2 = array:new([N], {fixed, infinity}),

  {Dist1Updated, _} = bfs(Edges, Node1, Dist1, 0),
  {Dist2Updated, _} = bfs(Edges, Node2, Dist2, 0),

  MinDist = lists:foldl(fun(I, Acc) ->
                            D1 = array:get(I, Dist1Updated),
                            D2 = array:get(I, Dist2Updated),
                            if
                              D1 =:= infinity orelse D2 =:= infinity ->
                                Acc;
                              true ->
                                Dist = max(D1, D2),
                                case Acc of
                                  {Min, Node} when Dist < Min ->
                                    {Dist, I};
                                  {Min, Node} when Dist =:= Min andalso I < Node ->
                                    {Dist, I};
                                  _ ->
                                    Acc
                                end
                            end
                        end, {infinity, -1}, lists:seq(0, N - 1)),

  case element(2, MinDist) of
    -1 -> -1;
    Node -> Node
  end.

bfs(Edges, StartNode, Dist, InitialDistance) ->
  N = length(Edges),
  Queue = queue:new(),
  DistUpdated = array:set(StartNode, InitialDistance, Dist),

  queue:in(StartNode, Queue1) = queue:new(),
  Queue2 = queue:in(StartNode, Queue1),

  bfs_helper(Edges, Queue2, DistUpdated).

bfs_helper(Edges, Queue, Dist) ->
  if
    queue:is_empty(Queue) ->
      {Dist, queue:size(Queue)};
    true ->
      {Value, QueueNext} = queue:out(Queue),
      {ok, CurrentNode} = Value,
      NextNode = lists:nth(CurrentNode + 1, Edges),

      if
        NextNode =:= -1 ->
          bfs_helper(Edges, QueueNext, Dist);
        true ->
          CurrentDist = array:get(CurrentNode, Dist),
          NextDist = array:get(NextNode, Dist),

          if
            NextDist =:= infinity ->
              NewDist = CurrentDist + 1,
              DistUpdated = array:set(NextNode, NewDist, Dist),
              Queue3 = queue:in(NextNode, QueueNext),
              bfs_helper(Edges, Queue3, DistUpdated);
            true ->
              bfs_helper(Edges, QueueNext, Dist)
          end
      end
  end.