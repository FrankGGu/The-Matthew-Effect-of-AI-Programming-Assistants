-module(solution).
-export([range_sum_bst/3]).

range_sum_bst(nil, _Low, _High) ->
    0;
range_sum_bst({'node', Val, Left, Right}, Low, High) ->
    SumWithCurrent = if
        Val >= Low andalso Val <= High -> Val;
        true -> 0
    end,

    SumFromLeft = if
        Val > Low -> range_sum_bst(Left, Low, High);
        true -> 0
    end,

    SumFromRight = if
        Val < High -> range_sum_bst(Right, Low, High);
        true -> 0
    end,

    SumWithCurrent + SumFromLeft + SumFromRight.