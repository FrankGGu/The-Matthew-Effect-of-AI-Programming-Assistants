-module(maximum_points).
-export([max_score/2]).

max_score(Cards, K) ->
    N = length(Cards),
    Sum = lists:sum(lists:sublist(Cards, N - K + 1, K)),
    max_score_helper(Cards, K, N, Sum, K).

max_score_helper(Cards, K, N, Max, 0) ->
    Max;
max_score_helper(Cards, K, N, Max, Remaining) ->
    NewMax = max(Max, Max - lists:nth(N - Remaining + 1, Cards) + lists:nth(Remaining, Cards)),
    max_score_helper(Cards, K, N, NewMax, Remaining - 1).

max(A, B) ->
    if A > B -> A; true -> B end.