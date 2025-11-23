-module(predict_the_winner).
-export([predict_the_winner/1]).

predict_the_winner(Nums) ->
    helper(Nums, 0, length(Nums) - 1, 0).

helper(_, Start, End, _) when Start > End ->
    0;
helper(Nums, Start, End, Turn) ->
    if
        Turn rem 2 == 0 ->
            max(
                lists:nth(Start + 1, Nums) + helper(Nums, Start + 1, End, Turn + 1),
                lists:nth(End + 1, Nums) + helper(Nums, Start, End - 1, Turn + 1)
            );
        true ->
            min(
                -lists:nth(Start + 1, Nums) + helper(Nums, Start + 1, End, Turn + 1),
                -lists:nth(End + 1, Nums) + helper(Nums, Start, End - 1, Turn + 1)
            )
    end.

predict_the_winner_result(Nums) ->
    Result = predict_the_winner(Nums),
    Result >= 0.