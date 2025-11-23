-module(fibonacci_sum).
-export([find_min_fibonacci_numbers/1]).

find_min_fibonacci_numbers(K) ->
  fib_list(K, [1, 1], 0).

fib_list(0, _, Count) ->
  Count;
fib_list(K, Fibs, Count) ->
  Last = lists:last(Fibs),
  case Last > K of
    true ->
      NewFibs = lists:reverse(tl(lists:reverse(Fibs))),
      MaxValue = lists:last(NewFibs),
      fib_list(K - MaxValue, NewFibs, Count + 1);
    false ->
      NewFibs = Fibs ++ [lists:last(Fibs) + lists:nth(length(Fibs) - 1, Fibs)],
      fib_list(K, NewFibs, Count)
  end.