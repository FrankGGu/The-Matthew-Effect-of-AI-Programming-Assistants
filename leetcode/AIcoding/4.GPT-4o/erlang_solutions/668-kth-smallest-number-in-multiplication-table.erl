-module(solution).
-export([find_kth_number/3]).

find_kth_number(M, N, K) ->
    low = 1,
    high = M * N,
    binary_search(low, high, M, N, K).

binary_search(Low, High, M, N, K) when Low < High ->
    Mid = (Low + High) div 2,
    Count = count_less_equal(Mid, M, N),
    if
        Count < K ->
            binary_search(Mid + 1, High, M, N, K);
        true ->
            binary_search(Low, Mid, M, N, K)
    end;
binary_search(Low, High, _, _, _) ->
    Low.

count_less_equal(X, M, N) ->
    Sum = lists:sum([min(X div i, N) || i <- lists:seq(1, M)]),
    Sum.