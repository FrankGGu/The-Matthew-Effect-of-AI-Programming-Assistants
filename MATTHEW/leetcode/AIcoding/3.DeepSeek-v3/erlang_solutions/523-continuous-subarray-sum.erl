-spec check_subarray_sum(Nums :: [integer()], K :: integer()) -> boolean().
check_subarray_sum(Nums, K) ->
    PrefixSum = 0,
    Map = #{0 => -1},
    check_subarray_sum(Nums, K, 0, PrefixSum, Map).

check_subarray_sum([], _, _, _, _) -> false;
check_subarray_sum([Num | Rest], K, Index, PrefixSum, Map) ->
    NewPrefixSum = PrefixSum + Num,
    case K of
        0 ->
            Rem = NewPrefixSum;
        _ ->
            Rem = NewPrefixSum rem K
    end,
    case maps:find(Rem, Map) of
        {ok, PrevIndex} ->
            if
                Index - PrevIndex >= 2 -> true;
                true -> check_subarray_sum(Rest, K, Index + 1, NewPrefixSum, Map)
            end;
        error ->
            NewMap = maps:put(Rem, Index, Map),
            check_subarray_sum(Rest, K, Index + 1, NewPrefixSum, NewMap)
    end.