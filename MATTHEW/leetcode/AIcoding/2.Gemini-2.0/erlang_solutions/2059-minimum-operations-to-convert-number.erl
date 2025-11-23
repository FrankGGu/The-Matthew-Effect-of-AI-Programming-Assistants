-module(minimum_operations).
-export([minimum_operations/3]).

minimum_operations(Nums, Start, Goal) ->
  queue_bfs(Nums, Start, Goal, queue:new(), #{Start => 0}).

queue_bfs(Nums, Goal, Goal, Queue, Visited) ->
  maps:get(Goal, Visited);
queue_bfs(Nums, Start, Goal, Queue, Visited) ->
  case queue:is_empty(Queue) of
    true ->
      queue_bfs(Nums, Goal, Goal, queue:from_list([Start]), maps:put(Start,0,Visited));
    false ->
      {H, T} = queue:get(Queue),
      queue_bfs_helper(Nums, H, Goal, T, Visited)
  end.

queue_bfs_helper(Nums, Curr, Goal, Queue, Visited) ->
  NewVisited =
    lists:foldl(
      fun(Num, Acc) ->
        Res1 = Curr + Num,
        Res2 = Curr - Num,
        Res3 = Curr bxor Num,
        Acc1 = update_visited(Res1, Curr, Goal, Queue, Acc),
        Acc2 = update_visited(Res2, Curr, Goal, Queue, Acc1),
        update_visited(Res3, Curr, Goal, Queue, Acc2)
      end,
      Visited,
      Nums
    ),
  case queue:is_empty(Queue) of
    true ->
      -1;
    false ->
      {H, T} = queue:get(Queue),
      queue_bfs_helper(Nums, H, Goal, T, NewVisited)
  end.

update_visited(Res, Curr, Goal, Queue, Visited) ->
  if
    Res >= 0 andalso Res =< 1000 andalso not maps:is_key(Res, Visited) ->
      NewQueue = queue:in(Res, Queue),
      maps:put(Res, maps:get(Curr, Visited) + 1, Visited);
    true ->
      Visited
  end.