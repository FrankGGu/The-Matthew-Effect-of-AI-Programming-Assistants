-spec maximum_energy(Energy :: [integer()]) -> integer().
maximum_energy(Energy) ->
    N = length(Energy),
    case N of
        0 -> 0;
        1 -> lists:nth(1, Energy);
        2 -> max(lists:nth(1, Energy), lists:nth(2, Energy));
        _ ->
            DP = lists:duplicate(N, 0),
            DP1 = setelement(1, DP, lists:nth(1, Energy)),
            DP2 = setelement(2, DP1, max(lists:nth(1, Energy), lists:nth(2, Energy))),
            DP3 = lists:foldl(fun(I, Acc) ->
                Prev1 = element(I - 1, Acc),
                Prev2 = element(I - 2, Acc),
                Current = lists:nth(I, Energy),
                setelement(I, Acc, max(Prev1, Prev2 + Current))
            end, DP2, lists:seq(3, N)),
            element(N, DP3)
    end.