-spec sample_stats(Count :: [integer()]) -> [float()].
sample_stats(Count) ->
    {Min, Max, Sum, Total, Mode, MaxCount} = lists:foldl(
        fun(Val, {CurrentMin, CurrentMax, CurrentSum, CurrentTotal, CurrentMode, CurrentMaxCount}) ->
            case Val > 0 of
                true ->
                    NewMin = case CurrentMin of
                        -1 -> Val;
                        _ -> min(CurrentMin, Val)
                    end,
                    NewMax = max(CurrentMax, Val),
                    NewSum = CurrentSum + Val * Val,
                    NewTotal = CurrentTotal + Val,
                    {NewMode, NewMaxCount} = case Val > CurrentMaxCount of
                        true -> {Val, Val};
                        false -> {CurrentMode, CurrentMaxCount}
                    end,
                    {NewMin, NewMax, NewSum, NewTotal, NewMode, NewMaxCount};
                false ->
                    {CurrentMin, CurrentMax, CurrentSum, CurrentTotal, CurrentMode, CurrentMaxCount}
            end
        end,
        {-1, -1, 0, 0, 0, 0},
        lists:zip(lists:seq(0, 255), Count)
    ),
    Mean = Sum / Total,
    Median = find_median(Count, Total),
    [Min, Max, Mean, Median, Mode].

find_median(Count, Total) ->
    {Left, Right} = case Total rem 2 of
        0 -> {Total div 2 - 1, Total div 2};
        1 -> {Total div 2, Total div 2}
    end,
    find_median(Count, 0, Left, Right, 0, 0, 0).

find_median(_, _, Left, Right, LeftVal, RightVal, _) when LeftVal =/= 0, RightVal =/= 0 ->
    (LeftVal + RightVal) / 2;
find_median([C | Rest], Index, Left, Right, LeftVal, RightVal, Acc) ->
    NewAcc = Acc + C,
    case NewAcc > Left of
        true when LeftVal =:= 0 ->
            NewLeftVal = Index;
        _ ->
            NewLeftVal = LeftVal
    end,
    case NewAcc > Right of
        true when RightVal =:= 0 ->
            NewRightVal = Index;
        _ ->
            NewRightVal = RightVal
    end,
    find_median(Rest, Index + 1, Left, Right, NewLeftVal, NewRightVal, NewAcc);
find_median([], _, _, _, LeftVal, RightVal, _) ->
    (LeftVal + RightVal) / 2.