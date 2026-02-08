-module(solution).
-export([rob/1]).

rob_linear_iter([], _Prev2Max, Prev1Max) ->
    Prev1Max;
rob_linear_iter([CurrentHouseMoney | RestOfHouses], Prev2Max, Prev1Max) ->
    CurrentMax = max(Prev1Max, Prev2Max + CurrentHouseMoney),
    rob_linear_iter(RestOfHouses, Prev1Max, CurrentMax).

rob_linear(Nums) ->
    rob_linear_iter(Nums, 0, 0).

rob(Nums) ->
    N = length(Nums),
    if
        N == 0 -> 0;
        N == 1 -> hd(Nums);
        true ->
            Max1 = rob_linear(lists:sublist(Nums, 1, N - 1)),
            Max2 = rob_linear(lists:nthtail(1, Nums)),
            max(Max1, Max2)
    end.