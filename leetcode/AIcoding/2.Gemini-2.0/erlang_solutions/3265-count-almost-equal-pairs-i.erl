-module(count_almost_equal_pairs_i).
-export([count_almost_equal_pairs/1]).

count_almost_equal_pairs(Nums) ->
    count_almost_equal_pairs(Nums, 0).

count_almost_equal_pairs([], Count) ->
    Count;
count_almost_equal_pairs([H | T], Count) ->
    NewCount = Count + count_almost_equal_pairs_helper(H, T),
    count_almost_equal_pairs(T, NewCount).

count_almost_equal_pairs_helper(_, []) ->
    0;
count_almost_equal_pairs_helper(Num, [H | T]) ->
    Count = case abs(Num - H) =< 1 of
                true -> 1;
                false -> 0
            end,
    Count + count_almost_equal_pairs_helper(Num, T).