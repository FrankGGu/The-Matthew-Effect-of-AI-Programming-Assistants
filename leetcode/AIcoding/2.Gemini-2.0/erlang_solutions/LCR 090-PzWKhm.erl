-module(rob).
-export([rob/1]).

rob(Nums) ->
  N = length(Nums),
  if
    N == 0 ->
      0;
    N == 1 ->
      lists:nth(1, Nums);
    N == 2 ->
      max(lists:nth(1, Nums), lists:nth(2, Nums));
    true ->
      Max1 = rob_helper(lists:sublist(Nums, 1, N - 1)),
      Max2 = rob_helper(lists:sublist(Nums, 2, N - 1)),
      max(Max1, Max2)
  end.

rob_helper(Nums) ->
  N = length(Nums),
  case N of
    0 ->
      0;
    1 ->
      lists:nth(1, Nums);
    2 ->
      max(lists:nth(1, Nums), lists:nth(2, Nums));
    _ ->
      Dp = lists:foldl(fun(I, Acc) ->
                           case I of
                             1 ->
                               [lists:nth(1, Nums) | Acc];
                             2 ->
                               [max(lists:nth(1, Nums), lists:nth(2, Nums)) | Acc];
                             _ ->
                               [max(lists:nth(I, Nums) + lists:nth(I - 2, lists:reverse(Acc)), lists:nth(I - 1, lists:reverse(Acc))) | Acc]
                           end
                         end, [], lists:seq(1, N)),
      lists:nth(N, lists:reverse(Dp))
  end.

max(A, B) ->
  if A > B -> A; true -> B end.