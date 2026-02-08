-spec longest_subsequence(Arr :: [integer()]) -> integer().
longest_subsequence(Arr) ->
    N = length(Arr),
    DP = lists:duplicate(N, 1),
    {_, Max} = lists:foldl(fun(I, {DPAcc, MaxAcc}) ->
        lists:foldl(fun(J, {DPInner, MaxInner}) ->
            Diff = lists:nth(I, Arr) - lists:nth(J, Arr),
            if
                Diff >= 0 ->
                    NewDP = lists:nth(J, DPInner) + 1,
                    if
                        NewDP > lists:nth(I, DPInner) ->
                            NewDPInner = setelement(I, DPInner, NewDP),
                            NewMax = max(MaxInner, NewDP),
                            {NewDPInner, NewMax};
                        true ->
                            {DPInner, MaxInner}
                    end;
                true ->
                    {DPInner, MaxInner}
            end
        end, {DPAcc, MaxAcc}, lists:seq(1, I - 1))
    end, {list_to_tuple(DP), 1}, lists:seq(2, N)),
    Max.