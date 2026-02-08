-module(solution).
-export([rearrange_sticks/2]).

rearrange_sticks(N, K) ->
    DP = lists:duplicate(K + 1, 0),
    DP1 = lists:keyreplace(1, 1, DP, {1, 1}),
    rearrange_sticks(N, K, DP1).

rearrange_sticks(1, 1, DP) ->
    {1, Val} = lists:keyfind(1, 1, DP),
    Val;
rearrange_sticks(N, K, DP) when N > 1 ->
    NewDP = lists:foldl(fun(I, Acc) ->
        {I, PrevVal} = lists:keyfind(I, 1, Acc),
        NewVal = (PrevVal * (N - 1) + (case lists:keyfind(I - 1, 1, Acc) of
                                          {I - 1, V} -> V;
                                          false -> 0
                                      end)) rem 1000000007,
        lists:keyreplace(I, 1, Acc, {I, NewVal})
    end, DP, lists:seq(1, K)),
    rearrange_sticks(N - 1, K, NewDP).