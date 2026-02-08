-module(count_almost_equal_pairs_ii).
-export([count_almost_equal_pairs/4]).

count_almost_equal_pairs(Nums, Threshold, K, Dist) ->
    count_almost_equal_pairs(Nums, Threshold, K, Dist, 0, 0).

count_almost_equal_pairs([], _, _, _, Acc, _) ->
    Acc;
count_almost_equal_pairs([H | T], Threshold, K, Dist, Acc, I) ->
    NewAcc = count_almost_equal_pairs(T, Threshold, K, Dist, Acc, I + 1, H, Threshold, K, Dist, Nums, I),
    count_almost_equal_pairs(T, Threshold, K, Dist, NewAcc, I + 1).

count_almost_equal_pairs([], _, _, _, Acc, _, _, _, _, _, _) ->
    Acc;
count_almost_equal_pairs([H | T], Threshold, K, Dist, Acc, I, Val, Threshold0, K0, Dist0, Nums, StartIndex) ->
    if
        I > StartIndex,
        abs(Val - H) =< Threshold0,
        abs(I - StartIndex) =< Dist0
    ->
        NewAcc = Acc + 1;
    true ->
        NewAcc = Acc
    end,
    count_almost_equal_pairs(T, Threshold, K, Dist, NewAcc, I + 1, Val, Threshold0, K0, Dist0, Nums, StartIndex).