-module(solution).
-export([max_sum_partition/2]).

max_sum_partition(A, K) ->
    Max = length(A),
    DP = lists:duplicate(Max + 1, 0),
    max_sum_partition_helper(A, K, 0, DP).

max_sum_partition_helper(_, 0, _, DP) ->
    lists:last(DP);
max_sum_partition_helper(A, K, Start, DP) ->
    Max = length(A),
    lists:foldl(fun(X, {I, DP1}) ->
                      NewDP = lists:duplicate(Max + 1, 0),
                      lists:foldl(fun(Y, J) ->
                                       Sum = lists:sum(lists:nthlist(Start + 1, lists:sublist(A, Y))),
                                       MaxSum = max(DP1[J], Sum + lists:nth(0, DP1)),
                                       NewDP = lists:nthput(J, MaxSum, NewDP),
                                       NewDP
                                   end, NewDP, lists:seq(Start, Max)),
                      {I + 1, NewDP}
                  end, {0, DP}, lists:seq(Start, Max)).

nthlist(N, L) -> lists:nth(N, L).