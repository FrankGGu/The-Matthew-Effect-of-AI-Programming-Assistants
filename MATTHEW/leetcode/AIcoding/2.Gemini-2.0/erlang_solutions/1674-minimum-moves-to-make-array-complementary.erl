-module(minimum_moves).
-export([min_moves/2]).

min_moves(Nums, Limit) ->
  Diff = lists:foldl(
    fun(X, Acc) ->
      [0 | Acc]
    end, [], Nums),
  Delta = lists:foldl(
    fun(
      {A, B}, Acc) ->
        Sum = A + B,
        Min = min(A, B),
        Max = max(A, B),
        Acc1 = lists:nth(Sum - 1, Acc) + 1,
        Acc2 = lists:nth(Min + 1 - 1, Acc) -1 ,
        Acc3 = lists:nth(Sum - Max + Limit - 1, Acc) - 1,
        Acc4 = lists:nth(Max + Limit + 1 - 1, Acc) + 1,
        lists:replace(Sum -1, Acc1, lists:replace(Min + 1 - 1, Acc2, lists:replace(Sum - Max + Limit - 1, Acc3, lists:replace(Max + Limit + 1 - 1, Acc4, Acc))))
    end,
    Diff,
    lists:zip(lists:sublist(Nums, 1, length(Nums) div 2), lists:sublist(lists:reverse(Nums), 1, length(Nums) div 2))
  ),
  lists:foldl(
    fun(A, {Min, Sum}) ->
      {min(Min, Sum + A), Sum + A}
    end,
    {length(Nums), 0},
    lists:sublist(Delta, 2, 2 * Limit)
  ).