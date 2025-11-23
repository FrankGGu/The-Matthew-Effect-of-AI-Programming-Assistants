-module(burst_balloons).
-export([max_coins/1]).

max_coins(Nums) ->
  N = length(Nums);
  PaddedNums = [1 | Nums] ++ [1];
  Memo = array:new(N + 2, array:new(N + 2, 0));

  burst(PaddedNums, 1, N, Memo).

burst(Nums, L, R, Memo) ->
  case array:get(L, array:get(R, Memo)) of
    0 ->
      MaxCoins = lists:foldl(
                   fun(I, Acc) ->
                     Acc1 = element(I + 1, Nums);
                     Acc2 = element(L, Nums);
                     Acc3 = element(R + 1, Nums);
                     Acc4 = burst(Nums, L, I - 1, Memo);
                     Acc5 = burst(Nums, I + 1, R, Memo);
                     max(Acc, Acc1 * Acc2 * Acc3 + Acc4 + Acc5)
                   end,
                   0,
                   lists:seq(L, R)
                 );
      array:set(L, array:set(R, Memo, MaxCoins)),
      MaxCoins;
    Val ->
      Val
  end.