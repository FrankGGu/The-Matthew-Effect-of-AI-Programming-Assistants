-spec max_subarray_sum_div_k(Nums :: [integer()], K :: integer()) -> integer().
max_subarray_sum_div_k(Nums, K) ->
    PrefixSum = 0,
    Remainders = #{0 => -1},
    MaxSum = -1000000000,
    {_, FinalMax} = lists:foldl(fun(Num, {Sum, CurrentMax}) ->
        NewSum = Sum + Num,
        Remainder = case NewSum rem K of
            R when R < 0 -> R + K;
            R -> R
        end,
        case maps:find(Remainder, Remainders) of
            {ok, Index} ->
                NewMax = max(CurrentMax, NewSum - lists:sum(lists:sublist(Nums, 1, Index + 1))),
                {NewSum, NewMax};
            error ->
                maps:put(Remainder, Sum, Remainders),
                {NewSum, CurrentMax}
        end
    end, {PrefixSum, MaxSum}, Nums),
    case FinalMax > -1000000000 of
        true -> FinalMax;
        false -> 0
    end.