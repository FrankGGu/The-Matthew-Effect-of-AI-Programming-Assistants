-spec maximum_subarray_sum(Nums :: [integer()], K :: integer()) -> integer().
maximum_subarray_sum(Nums, K) ->
    Prefix = lists:foldl(fun(X, Acc) -> [hd(Acc) + X | Acc] end, [0], Nums),
    PrefixList = lists:reverse(Prefix),
    Map = maps:new(),
    {MaxSum, _} = lists:foldl(fun(P, {CurrentMax, M}) ->
        case maps:get(P rem K, M, not_found) of
            not_found -> 
                {CurrentMax, maps:put(P rem K, P, M)};
            PrevP ->
                NewMax = max(CurrentMax, P - PrevP),
                {NewMax, M}
        end
    end, {-2000000000, Map}, PrefixList),
    MaxSum.