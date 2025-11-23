-module(smallest_value).
-export([smallestValue/1]).

smallestValue(N) ->
  smallestValue_helper(N).

smallestValue_helper(N) ->
  Sum = sum_prime_factors(N),
  if
    Sum =:= N -> N;
    true -> smallestValue_helper(Sum)
  end.

sum_prime_factors(N) ->
  sum_prime_factors_helper(N, 2, 0).

sum_prime_factors_helper(N, Factor, Sum) ->
  if
    N < 2 -> Sum;
    N rem Factor =:= 0 ->
      sum_prime_factors_helper(N div Factor, Factor, Sum + Factor);
    Factor * Factor > N ->
      Sum + N;
    true ->
      sum_prime_factors_helper(N, Factor + 1, Sum)
  end.