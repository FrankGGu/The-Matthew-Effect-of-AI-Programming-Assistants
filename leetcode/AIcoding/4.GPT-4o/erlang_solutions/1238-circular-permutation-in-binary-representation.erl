-module(solution).
-export([circular_permutation/2]).

circular_permutation(N, L) ->
    Perm = (1 bsl N) - 1,
    lists:map(fun(X) -> (X band Perm) bor ((L band 1) bsl (X - 1)) end, lists:seq(0, (1 bsl N) - 1)).