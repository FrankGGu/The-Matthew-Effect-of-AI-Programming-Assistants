-module(max_min_sums).
-export([max_min_sums/2]).

max_min_sums(Nums, K) ->
  {max_sum(Nums, K), min_sum(Nums, K)}.

max_sum(Nums, K) ->
  max_sum_helper(Nums, K, 0, lists:seq(1, K)).

min_sum(Nums, K) ->
  min_sum_helper(Nums, K, 0, lists:seq(1, K)).

max_sum_helper(Nums, K, MaxSoFar, Queue) ->
  case Nums of
    [] ->
      MaxSoFar;
    [H | T] ->
      NewQueue = lists:foldl(fun(Index, Acc) ->
                                  case lists:nth(Index, Queue) of
                                    _ when Index == length(Queue) ->
                                      Acc;
                                    Val when H > lists:nth(Val, Nums) ->
                                      lists:sublist(Acc, Index);
                                    _ ->
                                      Acc
                                  end
                              end, Queue, lists:seq(1, length(Queue))),

      NewQueue2 = [length(Nums) - length(T) | NewQueue],

      Sum = lists:sum([lists:nth(Index, Nums) || Index <- NewQueue2]),

      NewMaxSoFar = max(MaxSoFar, Sum),

      NewQueue3 = lists:droplast(NewQueue2),
      case T of
        [] ->
          NewMaxSoFar;
        _ ->
          max_sum_helper(T, K, NewMaxSoFar, NewQueue3)
      end
  end.

min_sum_helper(Nums, K, MinSoFar, Queue) ->
  case Nums of
    [] ->
      MinSoFar;
    [H | T] ->
      NewQueue = lists:foldl(fun(Index, Acc) ->
                                  case lists:nth(Index, Queue) of
                                    _ when Index == length(Queue) ->
                                      Acc;
                                    Val when H < lists:nth(Val, Nums) ->
                                      lists:sublist(Acc, Index);
                                    _ ->
                                      Acc
                                  end
                              end, Queue, lists:seq(1, length(Queue))),

      NewQueue2 = [length(Nums) - length(T) | NewQueue],

      Sum = lists:sum([lists:nth(Index, Nums) || Index <- NewQueue2]),

      NewMinSoFar = case MinSoFar of
                      0 -> Sum;
                      _ -> min(MinSoFar, Sum)
                    end,

      NewQueue3 = lists:droplast(NewQueue2),
      case T of
        [] ->
          NewMinSoFar;
        _ ->
          min_sum_helper(T, K, NewMinSoFar, NewQueue3)
      end
  end.