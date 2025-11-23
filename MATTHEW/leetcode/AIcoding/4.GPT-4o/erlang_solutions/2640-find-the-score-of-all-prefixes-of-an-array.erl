-module(solution).
-export([find_prefix_score/1]).

find_prefix_score(Arr) ->
    PrefixSum = lists:foldl(fun(X, {Sum, Acc}) -> 
        NewSum = Sum + X,
        NewAcc = Acc ++ [NewSum + Sum] 
    end, {0, []}, Arr),
    element(2, PrefixSum).