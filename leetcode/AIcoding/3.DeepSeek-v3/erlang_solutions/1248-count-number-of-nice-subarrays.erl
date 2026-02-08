-spec number_of_subarrays(Nums :: [integer()], K :: integer()) -> integer().
number_of_subarrays(Nums, K) ->
    number_of_subarrays(Nums, K, 0, 0, #{0 => 1}).

number_of_subarrays([], _K, _Count, _Prefix, Map) ->
    0;
number_of_subarrays([Num | Rest], K, Count, Prefix, Map) ->
    NewCount = if Num rem 2 == 1 -> Count + 1; true -> Count end,
    NewPrefix = NewCount - K,
    case maps:get(NewPrefix, Map, 0) of
        Value when is_integer(Value) ->
            Value + number_of_subarrays(Rest, K, NewCount, NewPrefix, maps:update_with(NewCount, fun(V) -> V + 1 end, 1, Map))
    end.