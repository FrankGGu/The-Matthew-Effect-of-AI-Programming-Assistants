-spec subarray_sum(Nums :: [integer()], K :: integer()) -> integer().
subarray_sum(Nums, K) ->
    Count = 0,
    Sum = 0,
    Map = #{0 => 1},
    subarray_sum(Nums, K, Count, Sum, Map).

subarray_sum([], _K, Count, _Sum, _Map) ->
    Count;
subarray_sum([Num | Rest], K, Count, Sum, Map) ->
    NewSum = Sum + Num,
    Count1 = case maps:get(NewSum - K, Map, 0) of
                 V when is_integer(V) -> Count + V
             end,
    NewMap = maps:update_with(NewSum, fun(V) -> V + 1 end, 1, Map),
    subarray_sum(Rest, K, Count1, NewSum, NewMap).