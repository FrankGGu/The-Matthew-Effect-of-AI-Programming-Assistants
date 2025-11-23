-module(kth_largest).
-export([find_kth_largest/2]).

find_kth_largest(Nums, K) ->
  QNums = list_to_queue(Nums),
  find_kth_largest_helper(QNums, K).

find_kth_largest_helper(QNums, K) ->
  find_kth_largest_helper(QNums, K, []).

find_kth_largest_helper(QNums, K, Sorted) ->
  case queue:is_empty(QNums) of
    true ->
      lists:nth(length(Sorted) - K + 1, Sorted);
    false ->
      {Value, RestQNums} = queue:dequeue(QNums),
      Sorted1 = insert_sorted(Value, Sorted),
      find_kth_largest_helper(RestQNums, K, Sorted1)
  end.

insert_sorted(Value, []) ->
  [Value];
insert_sorted(Value, [H|T]) ->
  if
    Value >= H ->
      [Value, H | T];
    true ->
      [H | insert_sorted(Value, T)]
  end.

list_to_queue(List) ->
  list_to_queue(List, queue:new()).

list_to_queue([], Queue) ->
  Queue;
list_to_queue([H|T], Queue) ->
  list_to_queue(T, queue:in(H, Queue)).