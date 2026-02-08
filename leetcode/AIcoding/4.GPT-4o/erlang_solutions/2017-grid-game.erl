-module(solution).
-export([gridGame/1]).

gridGame(Rows) ->
    N = length(Rows),
    PrefixSum = lists:foldl(fun(X, Acc) -> [hd(X) + hd(Acc)] ++ Acc end, [0], lists:reverse(Rows)),
    MaxPref = lists:max(PrefixSum),
    Total = lists:foldl(fun(X, Acc) -> Acc + lists:nth(1, X) end, 0, Rows),
    MinScore = Total - MaxPref,
    MinScore.