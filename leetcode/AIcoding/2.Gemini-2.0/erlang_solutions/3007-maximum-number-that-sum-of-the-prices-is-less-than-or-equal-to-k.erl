-module(solution).
-export([maximum_number_that_sum_of_prices_is_less_than_or_equal_to_k/1]).

maximum_number_that_sum_of_prices_is_less_than_or_equal_to_k(K) ->
  find_max_number(0, 10000000000, K).

find_max_number(Low, High, K) ->
  case Low > High of
    true ->
      Low - 1;
    false ->
      Mid = Low + (High - Low) div 2,
      Price = sum_of_prices(Mid),
      case Price =< K of
        true ->
          find_max_number(Mid + 1, High, K);
        false ->
          find_max_number(Low, Mid - 1, K)
      end
  end.

sum_of_prices(N) ->
  sum_of_prices_helper(N, 0).

sum_of_prices_helper(0, Acc) ->
  Acc;
sum_of_prices_helper(N, Acc) ->
  case is_power_of_two(N) of
    true ->
      sum_of_prices_helper(N - 1, Acc + N);
    false ->
      sum_of_prices_helper(N - 1, Acc + N)
  end.

is_power_of_two(N) ->
  (N > 0) andalso ((N band (N - 1)) == 0).