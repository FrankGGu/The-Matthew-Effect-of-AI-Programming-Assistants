-module(solution).
-export([combinationSum4/2]).

combinationSum4(Nums, Target) ->
    DP = array:new(Target + 1, 0),
    DP1 = array:set(0, 1, DP),
    solve(1, Target, Nums, DP1).

solve(I, Target, Nums, DP) when I =< Target ->
    CurrentCount = array:get(I, DP),
    NewCount = lists:foldl(fun(Num, Acc) ->
                                 IfIndex = I - Num,
                                 case IfIndex >= 0 of
                                     true -> Acc + array:get(IfIndex, DP);
                                     false -> Acc
                                 end
                         end, CurrentCount, Nums),
    UpdatedDP = array:set(I, NewCount, DP),
    solve(I + 1, Target, Nums, UpdatedDP);
solve(_I, Target, _Nums, DP) ->
    array:get(Target, DP).