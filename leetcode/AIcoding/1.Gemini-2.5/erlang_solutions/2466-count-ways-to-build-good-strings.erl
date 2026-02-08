-module(solution).
-export([countGoodStrings/4]).

countGoodStrings(Low, High, Zero, One) ->
    MOD = 1000000007,

    Dp = array:new([{size, High + 1}, {fixed, true}, {default, 0}, {index_base, 0}]),

    Dp1 = array:set(0, 1, Dp),

    DpFinal = lists:foldl(fun(I, CurrentDp) ->
        Val = 0,
        NewVal = Val,

        NewVal1 = if I >= Zero ->
                        (NewVal + array:get(I - Zero, CurrentDp)) rem MOD;
                   true -> NewVal
                end,

        NewVal2 = if I >= One ->
                        (NewVal1 + array:get(I - One, CurrentDp)) rem MOD;
                   true -> NewVal1
                end,
        array:set(I, NewVal2, CurrentDp)
    end, Dp1, lists:seq(1, High)),

    Result = lists:foldl(fun(I, Acc) ->
        (Acc + array:get(I, DpFinal)) rem MOD
    end, 0, lists:seq(Low, High)),

    Result.