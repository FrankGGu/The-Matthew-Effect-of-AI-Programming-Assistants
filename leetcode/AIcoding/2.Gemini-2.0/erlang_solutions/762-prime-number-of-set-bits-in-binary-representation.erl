-module(solution).
-export([count_prime_set_bits/2]).

count_prime_set_bits(Left, Right) ->
  lists:sum([case is_prime(count_set_bits(I)) of true -> 1; false -> 0 end || I <- lists:seq(Left, Right)]).

count_set_bits(N) ->
  count_set_bits(N, 0).

count_set_bits(0, Count) ->
  Count;
count_set_bits(N, Count) ->
  count_set_bits(N band (N - 1), Count + 1).

is_prime(N) ->
  case N of
    2 -> true;
    3 -> true;
    5 -> true;
    7 -> true;
    11 -> true;
    13 -> true;
    17 -> true;
    19 -> true;
    _ -> false
  end.