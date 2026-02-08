-module(target_sum).
-export([findTargetSumWays/2]).

findTargetSumWays(Nums, Target) ->
    findTargetSumWays(Nums, Target, 0, 0).

findTargetSumWays([], Target, Sum, Count) ->
    if Sum == Target then
        Count + 1
    else
        Count
    end;
findTargetSumWays([H|T], Target, Sum, Count) ->
    findTargetSumWays(T, Target, Sum + H, Count) +
    findTargetSumWays(T, Target, Sum - H, Count).