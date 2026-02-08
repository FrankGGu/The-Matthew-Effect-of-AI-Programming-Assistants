-module(kth_largest).
-export([findKthLargest/2]).

findKthLargest(Nums, K) ->
  Q = queue:from_list(Nums),
  findKthLargest(Q, K, []).

findKthLargest(Q, K, Acc) ->
  case queue:is_empty(Q) of
    true ->
      Sorted = lists:sort(Acc),
      lists:nth(length(Sorted) - K + 1, Sorted);
    false ->
      {Value, Q1} = queue:out(Q),
      findKthLargest(Q1, K, [Value | Acc])
  end.