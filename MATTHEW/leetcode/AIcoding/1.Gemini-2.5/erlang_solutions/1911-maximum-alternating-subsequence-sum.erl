-module(solution).
-export([max_alternating_sum/1]).

max_alternating_sum(Nums) ->
    {DpEven, _DpOdd} = lists:foldl(
        fun(Num, {CurrentDpEven, CurrentDpOdd}) ->
            NewDpEven = max(CurrentDpEven, CurrentDpOdd + Num),
            NewDpOdd = max(CurrentDpOdd, CurrentDpEven - Num),
            {NewDpEven, NewDpOdd}
        end,
        {0, 0}, % Initial {max_sum_ending_with_plus, max_sum_ending_with_minus}
        Nums
    ),
    DpEven.