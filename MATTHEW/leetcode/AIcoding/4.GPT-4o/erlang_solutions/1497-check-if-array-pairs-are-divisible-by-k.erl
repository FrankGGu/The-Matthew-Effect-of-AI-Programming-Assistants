-module(solution).
-export([canArrange/2]).

canArrange(Array, K) ->
    Remainders = lists:map(fun(X) -> (X rem K + K) rem K end, Array),
    Counts = lists:foldl(fun(R, Acc) -> lists:keystore(R, 1, Acc, {R, 0}) end, lists:duplicate(K, {0, 0}), Remainders),
    lists:all(fun({R, C}) -> C rem 2 == 0 end, Counts) andalso
    lists:all(fun({R, C}) -> C == 0 orelse C == K - R end, Counts).