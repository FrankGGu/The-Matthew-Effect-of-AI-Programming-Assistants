-module(split_array_largest_sum).
-export([split_array/2]).

split_array(Nums, K) ->
  split_array_helper(Nums, K, 0, lists:sum(Nums)).

split_array_helper(Nums, K, Low, High) ->
  case Low >= High of
    true ->
      Low;
    false ->
      Mid = Low + (High - Low) div 2,
      case is_valid(Nums, K, Mid) of
        true ->
          split_array_helper(Nums, K, Low, Mid);
        false ->
          split_array_helper(Nums, K, Mid + 1, High)
      end
  end.

is_valid(Nums, K, MaxSum) ->
  is_valid_helper(Nums, K, MaxSum, 0, 1).

is_valid_helper([], _K, _MaxSum, _CurrentSum, _Count) ->
  true;
is_valid_helper([Num | Rest], K, MaxSum, CurrentSum, Count) ->
  case CurrentSum + Num > MaxSum of
    true ->
      case Count >= K of
        true ->
          false;
        false ->
          is_valid_helper([Num | Rest], K, MaxSum, Num, Count + 1)
      end;
    false ->
      is_valid_helper(Rest, K, MaxSum, CurrentSum + Num, Count)
  end.