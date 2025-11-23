-module(prime_pairs).
-export([sum_of_distinct, is_prime/1]).

is_prime(N) when N < 2 ->
    false;
is_prime(N) ->
    is_prime_helper(N, 2).

is_prime_helper(N, I) when I * I > N ->
    true;
is_prime_helper(N, I) when N rem I == 0 ->
    false;
is_prime_helper(N, I) ->
    is_prime_helper(N, I + 1).

sum_of_distinct(N) ->
  sum_of_distinct_helper(N, []).

sum_of_distinct_helper(N, Acc) ->
  sum_of_distinct_helper(N, 2, Acc).

sum_of_distinct_helper(N, I, Acc) when I >= (N + 1) div 2 + 1 ->
  lists:sort(Acc);
sum_of_distinct_helper(N, I, Acc) ->
  if
    is_prime(I) ->
      Complement = N - I;
      if
        is_prime(Complement) andalso Complement >= I ->
           sum_of_distinct_helper(N, I + 1, [ [I, Complement] | Acc]);
        true ->
           sum_of_distinct_helper(N, I + 1, Acc)
      end;
    true ->
      sum_of_distinct_helper(N, I + 1, Acc)
  end.