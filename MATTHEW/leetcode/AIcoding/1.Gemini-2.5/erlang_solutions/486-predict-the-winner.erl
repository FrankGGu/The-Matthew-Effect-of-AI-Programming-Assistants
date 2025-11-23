-module(solution).
-export([predictTheWinner/1]).

predictTheWinner(Nums) ->
    N = length(Nums),
    Table = ets:new(predict_winner_memo, [set, public, named_table]),
    ScoreDiff = calculate_score_diff(Nums, 0, N - 1),
    ets:delete(Table),
    ScoreDiff >= 0.

calculate_score_diff(Nums, Left, Right) ->
    if
        Left > Right -> 0;
        Left == Right -> lists:nth(Left + 1, Nums)
    else
        case ets:lookup(predict_winner_memo, {Left, Right}) of
            [{_, Score}] -> Score;
            [] ->
                ValLeft = lists:nth(Left + 1, Nums),
                ValRight = lists:nth(Right + 1, Nums),

                ScoreIfChooseLeft = ValLeft - calculate_score_diff(Nums, Left + 1, Right),
                ScoreIfChooseRight = ValRight - calculate_score_diff(Nums, Left, Right - 1),

                Score = max(ScoreIfChooseLeft, ScoreIfChooseRight),

                ets:insert(predict_winner_memo, {{Left, Right}, Score}),
                Score
        end
    end.