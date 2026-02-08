-spec longest_nice_subarray(Nums :: [integer()]) -> integer().
longest_nice_subarray(Nums) ->
    longest_nice_subarray(Nums, 0, 0, 0, 1, 0).

longest_nice_subarray([], _Left, _Right, _Mask, _MaxLen, MaxLen) ->
    MaxLen;
longest_nice_subarray([Num | Rest], Left, Right, Mask, CurrentMax, MaxLen) when (Mask band Num) =:= 0 ->
    NewMask = Mask bor Num,
    NewCurrentMax = max(CurrentMax, Right - Left + 1),
    longest_nice_subarray(Rest, Left, Right + 1, NewMask, NewCurrentMax, max(NewCurrentMax, MaxLen));
longest_nice_subarray([_ | Rest] = Nums, Left, Right, Mask, CurrentMax, MaxLen) ->
    NewLeft = Left + 1,
    NewMask = Mask band (bnot lists:nth(NewLeft, Nums)),
    longest_nice_subarray(Nums, NewLeft, Right, NewMask, CurrentMax, MaxLen).