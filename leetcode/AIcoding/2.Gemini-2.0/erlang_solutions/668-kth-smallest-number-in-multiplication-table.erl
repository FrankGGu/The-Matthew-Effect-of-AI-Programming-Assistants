-module(kth_smallest_multiplication_table).
-export([find_kth_number/3]).

find_kth_number(M, N, K) ->
    find_kth_number(1, M * N, M, N, K).

find_kth_number(Low, High, M, N, K) ->
    if Low >= High ->
        Low;
    true ->
        Mid = Low + (High - Low) div 2,
        if count_less_equal(Mid, M, N) < K ->
            find_kth_number(Mid + 1, High, M, N, K);
        true ->
            find_kth_number(Low, Mid, M, N, K)
    end.

count_less_equal(X, M, N) ->
    count_less_equal(X, M, N, 0).

count_less_equal(X, M, N, Acc) ->
    count_less_equal(X, M, N, 1, Acc).

count_less_equal(X, M, N, I, Acc) ->
    if I > M ->
        Acc;
    true ->
        Acc1 = min(X div I, N),
        count_less_equal(X, M, N, I + 1, Acc + Acc1)
    end.