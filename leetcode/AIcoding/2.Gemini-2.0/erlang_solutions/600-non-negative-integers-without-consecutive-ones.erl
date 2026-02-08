-module(non_negative_integers_without_consecutive_ones).
-export([find_integers/1]).

find_integers(N) ->
  Fib = fibonacci(32),
  find_integers(N, Fib, 31, 0).

find_integers(_N, _Fib, -1, Acc) ->
  Acc;
find_integers(N, Fib, K, Acc) ->
  case (N band (1 bsl K)) > 0 of
    true ->
      case (N band (1 bsl (K + 1))) > 0 of
        true ->
          Acc + Fib[K+1];
        false ->
          find_integers(N, Fib, K - 1, Acc + Fib[K+1])
      end;
    false ->
      find_integers(N, Fib, K - 1, Acc)
  end.

fibonacci(N) ->
  fibonacci(N, [1, 1]).

fibonacci(0, Acc) ->
  Acc;
fibonacci(1, Acc) ->
  Acc;
fibonacci(N, Acc) ->
  fibonacci(N - 1, [lists:last(Acc) + lists:nth(length(Acc) - 1, Acc) | Acc]).