-spec max_subarray_length(Nums :: [integer()], K :: integer()) -> integer().
max_subarray_length(Nums, K) ->
    {Left, Right, MaxLen, Freq} = {0, 0, 0, #{}},
    max_subarray_length(Nums, K, Left, Right, MaxLen, Freq).

max_subarray_length([], _K, _Left, _Right, MaxLen, _Freq) ->
    MaxLen;
max_subarray_length([Num | Rest], K, Left, Right, MaxLen, Freq) ->
    NewFreq = maps:update_with(Num, fun(V) -> V + 1 end, 1, Freq),
    case maps:get(Num, NewFreq) > K of
        true ->
            {NewLeft, NewFreq1} = adjust_left(Num, Left, Right, NewFreq, K),
            NewMaxLen = max(MaxLen, Right - NewLeft + 1),
            max_subarray_length(Rest, K, NewLeft + 1, Right + 1, NewMaxLen, NewFreq1);
        false ->
            NewMaxLen = max(MaxLen, Right - Left + 1),
            max_subarray_length(Rest, K, Left, Right + 1, NewMaxLen, NewFreq)
    end.

adjust_left(Num, Left, Right, Freq, K) ->
    case maps:get(Num, Freq) > K of
        true ->
            LeftNum = lists:nth(Left + 1, Freq),
            NewFreq = maps:update_with(LeftNum, fun(V) -> V - 1 end, Freq),
            adjust_left(Num, Left + 1, Right, NewFreq, K);
        false ->
            {Left, Freq}
    end.