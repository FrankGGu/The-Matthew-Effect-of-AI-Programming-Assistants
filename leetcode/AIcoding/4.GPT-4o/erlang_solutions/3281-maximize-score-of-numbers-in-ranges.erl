-module(solution).
-export([maximize_score/2]).

maximize_score(Nums, Ranges) ->
    SortedNums = lists:sort(fun({A, _}, {B, _}) -> A > B end, Nums),
    MaxScore = lists:foldl(fun(Range, Acc) ->
        {L, R} = Range,
        Count = lists:count(fun(X) -> X >= L andalso X =< R end, SortedNums),
        Acc + Count
    end, 0, Ranges),
    MaxScore.