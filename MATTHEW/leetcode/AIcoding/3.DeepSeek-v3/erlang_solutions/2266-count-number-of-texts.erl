-spec count_texts(PressedKeys :: unicode:unicode_binary()) -> integer().
count_texts(PressedKeys) ->
    Keys = binary_to_list(PressedKeys),
    DP = lists:duplicate(length(Keys) + 1, 0),
    DP1 = setelement(1, list_to_tuple(DP), 1),
    {Result, _} = lists:foldl(fun(Idx, {Dp, PrevKey}) ->
        CurrentKey = lists:nth(Idx, Keys),
        Count = case CurrentKey of
            $7 -> 4;
            $9 -> 4;
            _ -> 3
        end,
        Sum = 0,
        {NewDp, Sum1} = lists:foldl(fun(I, {DpAcc, SumAcc}) ->
            case Idx - I >= 0 andalso lists:nth(Idx - I + 1, Keys) == CurrentKey andalso I =< Count of
                true -> {DpAcc, (SumAcc + element(Idx - I + 1, DpAcc)) rem 1000000007};
                false -> {DpAcc, SumAcc}
            end
        end, {Dp, Sum}, lists:seq(1, Count)),
        NewDp1 = setelement(Idx + 1, NewDp, Sum1),
        {NewDp1, CurrentKey}
    end, {DP1, undefined}, lists:seq(1, length(Keys))),
    element(length(Keys) + 1, Result).