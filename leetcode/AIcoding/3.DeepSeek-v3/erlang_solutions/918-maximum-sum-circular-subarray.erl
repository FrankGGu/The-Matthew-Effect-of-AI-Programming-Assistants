-spec max_subarray_sum_circular(Nums :: [integer()]) -> integer().
max_subarray_sum_circular(Nums) ->
    Total = lists:sum(Nums),
    MaxSubarray = kadane(Nums, fun(X, Y) -> max(X, Y) end),
    MinSubarray = kadane(Nums, fun(X, Y) -> min(X, Y) end),
    case MaxSubarray > 0 of
        true -> max(MaxSubarray, Total - MinSubarray);
        false -> MaxSubarray
    end.

kadane(List, Compare) ->
    {MaxSum, _} = lists:foldl(fun(X, {GlobalMax, CurrentMax}) ->
        NewCurrentMax = Compare(X, CurrentMax + X),
        NewGlobalMax = Compare(GlobalMax, NewCurrentMax),
        {NewGlobalMax, NewCurrentMax}
    end, {hd(List), hd(List)}, tl(List)),
    MaxSum.