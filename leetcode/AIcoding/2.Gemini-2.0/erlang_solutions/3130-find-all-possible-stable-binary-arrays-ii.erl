-module(stable_binary_arrays).
-export([num_ways/2]).

num_ways(0, _) -> 1;
num_ways(_, 0) -> 1;
num_ways(n, k) when n < 0 or k < 0 -> 0;
num_ways(n, k) ->
    memo(n, k, #{}).

memo(N, K, Memo) ->
    case maps:get({N, K}, Memo, undefined) of
        undefined ->
            Result = (memo(N - 1, K, Memo) + memo(N - 1, K - 1, Memo)) rem 1000000007,
            memo(N, K, maps:put({N, K}, Result, Memo));
        Result ->
            Result
    end.