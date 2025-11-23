-module(solution).
-export([longest_ones/2]).

longest_ones(A, K) ->
    longest_ones(A, K, 0, 0, 0).

longest_ones([], _, Count, MaxCount, _) ->
    MaxCount;
longest_ones([H | T], K, Count, MaxCount, ZeroCount) when H =:= 1 ->
    longest_ones(T, K, Count + 1, max(MaxCount, Count + 1), ZeroCount);
longest_ones([0 | T], K, Count, MaxCount, ZeroCount) when ZeroCount < K ->
    longest_ones(T, K, Count + 1, MaxCount, ZeroCount + 1);
longest_ones([0 | T], K, Count, MaxCount, ZeroCount) ->
    longest_ones(T, K, Count - 1, MaxCount, ZeroCount).