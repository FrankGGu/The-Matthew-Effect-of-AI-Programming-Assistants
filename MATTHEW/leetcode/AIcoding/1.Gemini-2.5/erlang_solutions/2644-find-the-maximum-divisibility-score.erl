-module(solution).
-export([max_divisibility_score/2]).

max_divisibility_score(Nums, Divisors) ->
    [H | T] = Divisors,
    ScoreH = calculate_score(Nums, H),
    max_divisibility_score_helper(Nums, T, ScoreH, H).

max_divisibility_score_helper(_Nums, [], _MaxScore, BestDivisor) ->
    BestDivisor;
max_divisibility_score_helper(Nums, [D | RestDivisors], CurrentMaxScore, CurrentBestDivisor) ->
    ScoreD = calculate_score(Nums, D),
    if
        ScoreD > CurrentMaxScore ->
            max_divisibility_score_helper(Nums, RestDivisors, ScoreD, D);
        ScoreD == CurrentMaxScore andalso D < CurrentBestDivisor ->
            max_divisibility_score_helper(Nums, RestDivisors, ScoreD, D);
        true ->
            max_divisibility_score_helper(Nums, RestDivisors, CurrentMaxScore, CurrentBestDivisor)
    end.

calculate_score(Nums, D) ->
    lists:foldl(fun(N, Acc) ->
        if
            N rem D == 0 -> Acc + 1;
            true -> Acc
        end
    end, 0, Nums).