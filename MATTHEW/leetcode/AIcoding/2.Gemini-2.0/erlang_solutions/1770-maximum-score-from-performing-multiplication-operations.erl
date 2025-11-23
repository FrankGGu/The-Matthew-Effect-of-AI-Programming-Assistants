-module(maximum_score).
-export([maximum_score/2]).

maximum_score(Nums, Multipliers) ->
    N = length(Nums),
    M = length(Multipliers),
    Memo = dict:new(),
    maximum_score_helper(Nums, Multipliers, 0, 0, N - 1, Memo).

maximum_score_helper(Nums, Multipliers, OpIndex, Left, Right, Memo) ->
    case dict:find({OpIndex, Left, Right}, Memo) of
        {ok, Value} ->
            Value;
        error ->
            M = length(Multipliers),
            if OpIndex == M then
                0
            else
                Multiplier = lists:nth(OpIndex + 1, Multipliers),
                ScoreLeft = Multiplier * lists:nth(Left + 1, Nums) +
                            maximum_score_helper(Nums, Multipliers, OpIndex + 1, Left + 1, Right, Memo),
                ScoreRight = Multiplier * lists:nth(Right + 1, Nums) +
                             maximum_score_helper(Nums, Multipliers, OpIndex + 1, Left, Right - 1, Memo),
                MaxScore = max(ScoreLeft, ScoreRight),
                dict:store({OpIndex, Left, Right}, MaxScore, Memo),
                MaxScore
            end
    end.