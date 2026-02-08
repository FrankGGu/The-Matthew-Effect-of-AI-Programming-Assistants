-module(solution).
-export([num_of_subarrays/2]).

num_of_subarrays(Arr, K) ->
    N = length(Arr),
    Sum = lists:sum(lists:sublist(Arr, K)),
    count(Sum, Arr, K, N, 0, 0).

count(_, _, _, N, _, Acc) when N < 0 -> Acc;
count(Sum, Arr, K, N, I, Acc) ->
    NewSum = Sum - lists:nth(I, Arr),
    NextSum = NewSum + lists:nth(I + K, Arr),
    NewAcc = if
        (NewSum >= K * threshold()) -> Acc + 1;
        true -> Acc
    end,
    count(NextSum, Arr, K, N - 1, I + 1, NewAcc).

threshold() -> 1.