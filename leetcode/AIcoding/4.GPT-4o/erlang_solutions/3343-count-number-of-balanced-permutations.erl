-module(solution).
-export([countBalancedPermutations/1]).

countBalancedPermutations(N) when N rem 2 == 0 ->
    factorial(N) div (factorial(N div 2) * factorial(N div 2));
countBalancedPermutations(_) -> 0.

factorial(0) -> 1;
factorial(N) when N > 0 -> N * factorial(N - 1).