-module(solution).
-export([stoneGameIX/1]).

stoneGameIX(Stones) ->
    {Cnt0, Cnt1, Cnt2} = lists:foldl(
        fun(Stone, {Acc0, Acc1, Acc2}) ->
            case Stone rem 3 of
                0 -> {Acc0 + 1, Acc1, Acc2};
                1 -> {Acc0, Acc1 + 1, Acc2};
                2 -> {Acc0, Acc1, Acc2 + 1}
            end
        end,
        {0, 0, 0},
        Stones
    ),

    Cnt0Even = (Cnt0 rem 2 == 0),
    Cnt1Gt0 = (Cnt1 > 0),
    Cnt2Gt0 = (Cnt2 > 0),
    Cnt1Is1 = (Cnt1 == 1),
    Cnt2Is1 = (Cnt2 == 1),

    if Cnt0Even ->
        (Cnt1Gt0 and Cnt2Gt0) or (Cnt1Is1 xor Cnt2Is1);
    true -> % Cnt0 is odd
        (not (Cnt1Gt0 and Cnt2Gt0)) and (not (Cnt1Is1 xor Cnt2Is1))
    end.