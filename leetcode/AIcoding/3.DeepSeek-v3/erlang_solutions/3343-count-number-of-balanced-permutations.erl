-module(solution).
-export([count_balanced_permutations/1]).

count_balanced_permutations(N) ->
    case N rem 2 of
        1 -> 0;
        0 -> catalan(N div 2)
    end.

catalan(N) ->
    catalan(N, 1, 1).

catalan(0, Acc, _) -> Acc;
catalan(N, Acc, I) ->
    catalan(N - 1, Acc * 2 * (2 * I - 1) div (I + 1), I + 1).