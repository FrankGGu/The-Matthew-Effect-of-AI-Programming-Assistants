-module(count_arrays).
-export([k_increasing/3]).

k_increasing(N, K, M) ->
    memoized_count(N, K, M, []).

memoized_count(N, K, M, Memo) ->
    case lists:keyfind({N, K}, 1, Memo) of
        false ->
            Result = count(N, K, M),
            memoized_count(N, K, M, [{N, K, Result} | Memo]);
        {N, K, Result} ->
            Result
    end.

count(N, 0, M) ->
    factorial(N + M - 1) div (factorial(N) * factorial(M - 1));
count(N, K, M) when K >= N ->
    0;
count(N, K, M) ->
    (memoized_count(N - 1, K - 1, M, []) + memoized_count(N - 1, K, M, [])) rem 1000000007.

factorial(0) ->
    1;
factorial(N) ->
    factorial(N, 1).

factorial(0, Acc) ->
    Acc;
factorial(N, Acc) ->
    factorial(N - 1, (Acc * N) rem 1000000007).