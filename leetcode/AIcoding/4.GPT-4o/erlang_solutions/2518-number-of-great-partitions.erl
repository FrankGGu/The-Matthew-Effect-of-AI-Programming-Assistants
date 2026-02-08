-module(solution).
-export([countPartitions/2]).

countPartitions(N, K) ->
    M = 1000000007,
    dp(N, K, M, array:new(0)).

dp(0, 0, _, Memo) -> 1;
dp(_, 0, _, _) -> 0;
dp(N, K, M, Memo) ->
    case array:find({N, K}, Memo) of
        undefined ->
            S = lists:sum([dp(N - j, K - 1, M, Memo) rem M || j <- lists:seq(1, N div K)]),
            Memo1 = array:store({N, K}, S, Memo),
            S rem M;
        Val -> Val
    end.