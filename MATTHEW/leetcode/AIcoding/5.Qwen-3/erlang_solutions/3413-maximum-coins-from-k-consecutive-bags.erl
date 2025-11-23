-module(maximum_coins_from_k_consecutive_bags).
-export([max_coins/2]).

max_coins(Bags, K) ->
    N = length(Bags),
    Sum = lists:sum(lists:sublist(Bags, 1, K)),
    max_coins(Bags, K, N, Sum, Sum).

max_coins(_, _, N, Current, Max) when N == 0 ->
    Max;
max_coins(Bags, K, N, Current, Max) ->
    Next = lists:nth(N, Bags),
    Previous = lists:nth(N - K, Bags),
    NewCurrent = Current + Next - Previous,
    NewMax = max(Max, NewCurrent),
    max_coins(Bags, K, N - 1, NewCurrent, NewMax).