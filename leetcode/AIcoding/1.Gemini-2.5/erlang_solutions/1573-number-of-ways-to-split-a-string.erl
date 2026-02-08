-spec num_ways(S :: unicode:unicode_binary()) -> integer().
num_ways(S) ->
    SList = unicode:characters_to_list(S),
    N = length(SList),
    TotalOnes = lists:sum([1 || C <- SList, C == $1]),

    if
        TotalOnes rem 3 /= 0 -> 0;
        TotalOnes == 0 ->
            if
                N < 3 -> 0;
                true -> (N - 1) * (N - 2) div 2
            end;
        true ->
            TargetOnes = TotalOnes div 3,
            {_CurrentOnes, CountWays1, CountWays2} = lists:foldl(
                fun(Char, {CurrentOnesAcc, Ways1Acc, Ways2Acc}) ->
                    NewCurrentOnes = CurrentOnesAcc + (if Char == $1 -> 1; true -> 0 end),
                    NewWays1Acc = if NewCurrentOnes == TargetOnes -> Ways1Acc + 1; true -> Ways1Acc end,
                    NewWays2Acc = if NewCurrentOnes == 2 * TargetOnes -> Ways2Acc + 1; true -> Ways2Acc end,
                    {NewCurrentOnes, NewWays1Acc, NewWays2Acc}
                end,
                {0, 0, 0},
                lists:sublist(SList, N - 1)
            ),
            CountWays1 * CountWays2
    end.