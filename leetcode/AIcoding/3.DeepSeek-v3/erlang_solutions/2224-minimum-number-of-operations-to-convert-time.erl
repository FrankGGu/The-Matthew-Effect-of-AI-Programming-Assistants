-spec min_operations(Current :: unicode:unicode_binary(), Correct :: unicode:unicode_binary()) -> integer().
min_operations(Current, Correct) ->
    [CH, CM] = binary:split(Current, <<":">>),
    [TH, TM] = binary:split(Correct, <<":">>),
    CurrentMinutes = binary_to_integer(CH) * 60 + binary_to_integer(CM),
    TargetMinutes = binary_to_integer(TH) * 60 + binary_to_integer(TM),
    Diff = TargetMinutes - CurrentMinutes,
    count_operations(Diff).

count_operations(Diff) when Diff =< 0 ->
    count_operations(Diff + 24 * 60);
count_operations(Diff) ->
    Count = 0,
    count_operations(Diff, Count).

count_operations(0, Count) ->
    Count;
count_operations(Diff, Count) ->
    if
        Diff >= 60 ->
            count_operations(Diff - 60, Count + 1);
        Diff >= 15 ->
            count_operations(Diff - 15, Count + 1);
        Diff >= 5 ->
            count_operations(Diff - 5, Count + 1);
        true ->
            count_operations(Diff - 1, Count + 1)
    end.