-module(solution).
-export([max_points/1]).

max_points(Points) ->
    N = length(Points),
    DP = lists:duplicate(N, 0),
    {Max, _} = lists:foldl(fun(I, {MaxAcc, DpAcc}) ->
        case I of
            0 -> 
                NewDp = setelement(1, DpAcc, lists:nth(1, Points)),
                {max(MaxAcc, lists:nth(1, NewDp)), NewDp};
            1 ->
                Val = max(lists:nth(1, Points), lists:nth(2, Points)),
                NewDp = setelement(2, DpAcc, Val),
                {max(MaxAcc, Val), NewDp};
            _ ->
                Prev1 = lists:nth(I, DpAcc),
                Prev2 = lists:nth(I - 1, DpAcc),
                Prev3 = lists:nth(I - 2, DpAcc),
                Current = lists:nth(I + 1, Points),
                Val = max(Prev1, max(Prev2 + Current, Prev3 + Current)),
                NewDp = setelement(I + 1, DpAcc, Val),
                {max(MaxAcc, Val), NewDp}
        end
    end, {0, DP}, lists:seq(0, N - 1)),
    Max.