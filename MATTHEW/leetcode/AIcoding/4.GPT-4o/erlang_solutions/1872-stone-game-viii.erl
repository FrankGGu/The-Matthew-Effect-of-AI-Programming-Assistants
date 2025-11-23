-module(solution).
-export([stone_game_8/1]).

stone_game_8(Values) ->
    N = length(Values),
    PrefixSum = lists:foldl(fun(X, {Sum, Acc}) -> {Sum + X, [Sum + X | Acc]} end, {0, []}, Values),
    PrefixSumList = lists:reverse(element(2, PrefixSum)),
    stone_game_8_helper(PrefixSumList, N, hd(Values)).

stone_game_8_helper(PrefixSum, N, MaxScore) ->
    lists:foldl(fun(X, Acc) -> max(Acc, MaxScore =:= X andalso MaxScore) end, MaxScore, tl(PrefixSum)).