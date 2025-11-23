-module(max_tastiness).
-export([max_tastiness/2]).

max_tastiness(Prices, K) ->
    lists:sort(Prices),
    max_tastiness_helper(Prices, K, 0, length(Prices) - 1).

max_tastiness_helper(_, _, L, R) when L > R -> 0;
max_tastiness_helper(Prices, K, L, R) when K == 1 ->
    lists:max(lists:sublist(Prices, L+1, R-L+1));
max_tastiness_helper(Prices, K, L, R) ->
    Min = lists:min(lists:sublist(Prices, L+1, R-L+1)),
    Max = lists:max(lists:sublist(Prices, L+1, R-L+1)),
    Mid = (L + R) div 2,
    Left = max_tastiness_helper(Prices, K-1, L, Mid),
    Right = max_tastiness_helper(Prices, K-1, Mid+1, R),
    lists:min([Max - Min, Left, Right]).