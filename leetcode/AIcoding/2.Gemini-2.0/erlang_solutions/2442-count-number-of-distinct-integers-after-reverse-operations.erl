-module(count_distinct_integers_after_reverse).
-export([countDistinctIntegers/1]).

reverse(N) ->
    reverse_helper(N, 0).

reverse_helper(0, Acc) ->
    Acc;
reverse_helper(N, Acc) ->
    reverse_helper(N div 10, Acc * 10 + N rem 10).

countDistinctIntegers(Nums) ->
    Distinct = sets:new(),
    Distinct2 = lists:foldl(
        fun(Num, Acc) ->
            Acc2 = sets:add_element(Num, Acc),
            sets:add_element(reverse(Num), Acc2)
        end,
        Distinct,
        Nums
    ),
    sets:size(Distinct2).