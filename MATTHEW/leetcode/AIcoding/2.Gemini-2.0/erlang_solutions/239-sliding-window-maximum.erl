-module(sliding_window_maximum).
-export([max_sliding_window/2]).

max_sliding_window(Nums, K) ->
  Len = length(Nums),
  if Len < K,
    [],
    true ->
      max_sliding_window(Nums, K, [], [], 0, Len)
  end.

max_sliding_window(_Nums, _K, _Result, _Queue, I, Len) when I + _K > Len ->
  lists:reverse(_Result);
max_sliding_window(Nums, K, Result, Queue, I, Len) ->
  {NewQueue, Max} = update_queue(Nums, Queue, K, I),
  max_sliding_window(Nums, K, [Max | Result], NewQueue, I + 1, Len).

update_queue(Nums, Queue, K, I) ->
  {FilteredQueue, _} = lists:foldl(
    fun(X, {Acc, J}) ->
      if J < I,
        {Acc, J + 1},
        true ->
          {Acc ++ [X], J + 1}
      end
    end,
    {[], 0},
    Queue
  ),

  NewQueue = lists:foldl(
    fun(X, Acc) ->
      case Acc of
        [] ->
          [X];
        [H | T] ->
          if element(2, X) > element(2, H),
            [X];
            true ->
              [X | Acc]
          end
      end
    end,
    FilteredQueue,
    [{I + K -1, lists:nth(I + K - 1, Nums)}]
  ),

  MaxIndex = case NewQueue of
                [] -> I + K - 1;
                [H | _] -> element(1, H)
            end,

  {NewQueue, lists:nth(MaxIndex, Nums)}.