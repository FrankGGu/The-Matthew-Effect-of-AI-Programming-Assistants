-module(solution).
-export([max_score/1]).

max_score(Nums) ->
    N = length(Nums),
    ZeroCount = count_zero(Nums),
    OneCount = N - ZeroCount,
    max_score(Nums, 0, 0, 0, ZeroCount, OneCount, []).

max_score([], _, _, MaxScore, _, _, Result) ->
    lists:reverse(Result);
max_score([0 | Rest], Index, LeftZero, LeftOne, ZeroCount, OneCount, Result) ->
    CurrentScore = LeftZero + (OneCount - LeftOne),
    case CurrentScore of
        Score when Score > MaxScore ->
            max_score(Rest, Index + 1, LeftZero + 1, LeftOne, ZeroCount, OneCount, [Index | Result]);
        Score when Score == MaxScore ->
            max_score(Rest, Index + 1, LeftZero + 1, LeftOne, ZeroCount, OneCount, [Index | Result]);
        _ ->
            max_score(Rest, Index + 1, LeftZero + 1, LeftOne, ZeroCount, OneCount, Result)
    end;
max_score([1 | Rest], Index, LeftZero, LeftOne, ZeroCount, OneCount, Result) ->
    CurrentScore = LeftZero + (OneCount - LeftOne),
    case CurrentScore of
        Score when Score > MaxScore ->
            max_score(Rest, Index + 1, LeftZero, LeftOne + 1, ZeroCount, OneCount, [Index | Result]);
        Score when Score == MaxScore ->
            max_score(Rest, Index + 1, LeftZero, LeftOne + 1, ZeroCount, OneCount, [Index | Result]);
        _ ->
            max_score(Rest, Index + 1, LeftZero, LeftOne + 1, ZeroCount, OneCount, Result)
    end.

count_zero([]) -> 0;
count_zero([0 | Rest]) -> 1 + count_zero(Rest);
count_zero([_ | Rest]) -> count_zero(Rest).