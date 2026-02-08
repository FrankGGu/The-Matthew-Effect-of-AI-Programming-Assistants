-spec min_sub_array_len(Target :: integer(), Nums :: [integer()]) -> integer().
min_sub_array_len(Target, Nums) ->
    min_sub_array_len(Target, Nums, 0, 0, 0, length(Nums) + 1).

min_sub_array_len(_, _, Sum, Left, Right, MinLen) when Sum < 0 ->
    MinLen;
min_sub_array_len(Target, Nums, Sum, Left, Right, MinLen) when Sum >= Target ->
    NewMinLen = min(MinLen, Right - Left),
    min_sub_array_len(Target, Nums, Sum - lists:nth(Left + 1, Nums), Left + 1, Right, NewMinLen);
min_sub_array_len(Target, Nums, Sum, Left, Right, MinLen) when Right < length(Nums) ->
    min_sub_array_len(Target, Nums, Sum + lists:nth(Right + 1, Nums), Left, Right + 1, MinLen);
min_sub_array_len(_, _, _, _, _, MinLen) ->
    case MinLen =:= length(Nums) + 1 of
        true -> 0;
        false -> MinLen
    end.