-module(solution).
-export([sum_prefix_scores/1]).

sum_prefix_scores(Words) ->
    PrefixScores = lists:foldl(fun(Word, Acc) ->
        {Score, NewAcc} = lists:foldl(fun(C, {S, M}) ->
            NewScore = S + M,
            {NewScore, M + 1}
        end, {0, 1}, Word),
        NewAcc ++ [Score + hd(NewAcc)]
    end, [0], Words),
    tl(PrefixScores).