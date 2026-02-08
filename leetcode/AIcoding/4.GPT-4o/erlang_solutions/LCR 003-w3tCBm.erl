-module(solution).
-export([countBits/1]).

countBits(N) ->
    lists:map(fun(X) -> count_ones(X) end, lists:seq(0, N)).

count_ones(0) -> 0;
count_ones(N) -> (N band 1) + count_ones(N bsr 1).