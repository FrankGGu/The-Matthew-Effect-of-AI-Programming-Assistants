-spec min_sub_array_len(Target :: integer(), Nums :: [integer()]) -> integer().
min_sub_array_len(Target, Nums) ->
    min_sub_array_len(Target, Nums, 0, 0, 0, length(Nums) + 1).

min_sub_array_len(_, _, Sum, Left, Right, MinLen) when Sum < 0 ->
    min_sub_array_len(0, [], Sum, Left, Right, MinLen);
min_sub_array_len(Target, Nums, Sum, Left, Right, MinLen) when Right < length(Nums) ->
    NewSum = Sum + lists:nth(Right + 1, Nums),
    if
        NewSum >= Target ->
            NewMinLen = min(MinLen, Right - Left + 1),
            min_sub_array_len(Target, Nums, NewSum - lists:nth(Left + 1, Nums), Left + 1, Right, NewMinLen);
        true ->
            min_sub_array_len(Target, Nums, NewSum, Left, Right + 1, MinLen)
    end;
min_sub_array_len(_, _, _, _, _, MinLen) ->
    if
        MinLen =:= length(Nums) + 1 -> 0;
        true -> MinLen
    end.