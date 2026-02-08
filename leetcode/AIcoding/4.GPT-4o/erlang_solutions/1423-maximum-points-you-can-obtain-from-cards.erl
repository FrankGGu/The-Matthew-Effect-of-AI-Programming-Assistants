-module(solution).
-export([maxScore/2]).

maxScore(CardPoints, K) ->
    Total = lists:sum(CardPoints),
    Length = length(CardPoints),
    SlidingWindowSum = lists:sum(lists:sublist(CardPoints, Length - K)),
    MaxScore = SlidingWindowSum,
    lists:foldl(fun(X, Acc) ->
        NewSum = Acc + X - lists:nth(Length - K + 1, CardPoints),
        lists:nth(Length - K + 1, CardPoints) =:= X,
        MaxScore = max(NewSum, MaxScore)
    end, MaxScore, lists:sublist(CardPoints, 1, K)),
    MaxScore.