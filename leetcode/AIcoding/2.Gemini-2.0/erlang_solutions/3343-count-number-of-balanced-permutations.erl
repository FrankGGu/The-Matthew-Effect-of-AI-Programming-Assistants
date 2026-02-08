-module(balanced_permutations).
-export([count_balanced_permutations/1]).

count_balanced_permutations(N) ->
  case N rem 2 of
    0 ->
      Half = N div 2,
      factorial(N) div (factorial(Half) * factorial(Half));
    1 ->
      0
  end.

factorial(0) -> 1;
factorial(N) -> N * factorial(N - 1).