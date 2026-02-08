-module(solution).
-export([max_factor_score/1]).

max_factor_score(Nums) ->
    MaxScore = lists:foldl(fun(Num, Acc) ->
        Score = factor_score(Num),
        if
            Score > Acc -> Score;
            true -> Acc
        end
    end, 0, Nums),
    MaxScore.

factor_score(N) ->
    factor_score(N, 1, 0).

factor_score(N, I, Acc) when I > N ->
    Acc;
factor_score(N, I, Acc) ->
    case N rem I of
        0 ->
            factor_score(N, I + 1, Acc + I);
        _ ->
            factor_score(N, I + 1, Acc)
    end.