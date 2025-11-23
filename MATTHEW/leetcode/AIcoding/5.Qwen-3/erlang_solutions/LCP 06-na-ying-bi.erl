-module(leetcode_coin_pile).
-export([minOperationsToMakeZero/1]).

minOperationsToMakeZero(Coins) ->
    minOperationsToMakeZero(Coins, 0).

minOperationsToMakeZero([], Acc) ->
    Acc;
minOperationsToMakeZero([H | T], Acc) ->
    minOperationsToMakeZero(T, Acc + H).