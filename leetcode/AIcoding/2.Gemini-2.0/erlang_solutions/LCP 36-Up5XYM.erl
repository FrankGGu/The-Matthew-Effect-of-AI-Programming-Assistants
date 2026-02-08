-module(solution).
-export([maximum_groups/1]).

maximum_groups(piles) ->
    N = length(piles),
    maximum_groups(piles, 0, 1, N).

maximum_groups(_, Acc, K, N) when Acc + K > N ->
    K - 1;
maximum_groups(Piles, Acc, K, N) ->
    maximum_groups(Piles, Acc + K, K + 1, N).