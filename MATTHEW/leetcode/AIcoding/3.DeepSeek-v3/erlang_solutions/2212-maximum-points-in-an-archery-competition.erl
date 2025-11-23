-module(solution).
-export([maximum_bob_points/2]).

maximum_bob_points(NumArrows, AliceArrows) ->
    Max = 12,
    MaxMask = 1 bsl Max,
    {MaxPoints, BestMask} = lists:foldl(
        fun(Mask, {MaxP, BestM}) ->
            Points = 0,
            Arrows = 0,
            {NewPoints, NewArrows} = lists:foldl(
                fun(I, {P, A}) ->
                    case (Mask band (1 bsl I)) =/= 0 of
                        true ->
                            {P + I, A + lists:nth(I + 1, AliceArrows) + 1};
                        false ->
                            {P, A}
                    end
                end,
                {Points, Arrows},
                lists:seq(0, Max - 1)
            ),
            if
                NewArrows =< NumArrows andalso NewPoints > MaxP ->
                    {NewPoints, Mask};
                true ->
                    {MaxP, BestM}
            end
        end,
        {0, 0},
        lists:seq(0, MaxMask - 1)
    ),
    BobArrows = lists:map(
        fun(I) ->
            case (BestMask band (1 bsl I)) =/= 0 of
                true ->
                    lists:nth(I + 1, AliceArrows) + 1;
                false ->
                    0
            end
        end,
        lists:seq(0, Max - 1)
    ),
    Remaining = NumArrows - lists:sum(BobArrows),
    if
        Remaining > 0 ->
            [H|T] = BobArrows,
            NewH = H + Remaining,
            [NewH | T];
        true ->
            BobArrows
    end.