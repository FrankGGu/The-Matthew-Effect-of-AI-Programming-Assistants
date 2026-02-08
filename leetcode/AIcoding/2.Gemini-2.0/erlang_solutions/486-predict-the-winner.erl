-module(predict_winner).
-export([predict_the_winner/1]).

predict_the_winner(Nums) ->
    score_diff(Nums, 0, length(Nums) - 1) >= 0.

score_diff(Nums, Left, Right) ->
    if Left =:= Right ->
        lists:nth(Left + 1, Nums)
    else
        MaxLeft = lists:nth(Left + 1, Nums) - score_diff(Nums, Left + 1, Right),
        MaxRight = lists:nth(Right + 1, Nums) - score_diff(Nums, Left, Right - 1),
        max(MaxLeft, MaxRight)
    end.

max(A, B) ->
    if A > B -> A;
    true -> B
    end.