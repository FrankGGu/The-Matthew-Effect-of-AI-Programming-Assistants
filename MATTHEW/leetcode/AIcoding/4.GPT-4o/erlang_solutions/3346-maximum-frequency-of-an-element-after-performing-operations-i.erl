-module(solution).
-export([maxFrequency/2]).

maxFrequency(A, K) ->
    N = length(A),
    SortedA = lists:sort(A),
    max_frequency(SortedA, K, N, 0, 0, 0).

max_frequency([], _, _, _, MaxFreq, _) -> MaxFreq;
max_frequency(A, K, N, L, MaxFreq, TotalSum) ->
    {H, _} = lists:split(L, A),
    NewTotalSum = TotalSum + lists:nth(L + 1, A),
    WindowSize = L + 1,
    if
        NewTotalSum - (WindowSize - 1) * lists:nth(L + 1, A) > K ->
            max_frequency(A, K, N, L + 1, MaxFreq, NewTotalSum);
        true ->
            max_frequency(A, K, N, L + 1, max(MaxFreq, WindowSize), NewTotalSum)
    end.