-module(solution).
-export([find_kth_number/3]).

-spec find_kth_number(M :: integer(), N :: integer(), K :: integer()) -> integer().
find_kth_number(M, N, K) ->
    Low = 1,
    High = M * N,

    binary_search(Low, High, M, N, K).

binary_search(Low, High, M, N, K) when Low < High ->
    Mid = Low + (High - Low) div 2,

    Count = count_less_equal(Mid, M, N),

    if
        Count < K ->
            binary_search(Mid + 1, High, M, N, K);
        true -> % Count >= K
            binary_search(Low, Mid, M, N, K)
    end;
binary_search(Low, _High, _M, _N, _K) ->
    Low.

count_less_equal(Val, M, N) ->
    count_less_equal_loop(1, M, N, Val, 0).

count_less_equal_loop(I, M, N, Val, Acc) when I =< M ->
    NumInRow = erlang:min(N, Val div I),
    count_less_equal_loop(I + 1, M, N, Val, Acc + NumInRow);
count_less_equal_loop(_I, _M, _N, _Val, Acc) ->
    Acc.