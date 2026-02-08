-spec subarrays_div_by_k(Nums :: [integer()], K :: integer()) -> integer().
subarrays_div_by_k(Nums, K) ->
    Prefix = 0,
    Count = 0,
    ModMap = #{0 => 1},
    {_, Result} = lists:foldl(fun(Num, {CurrentPrefix, CurrentCount}) ->
        NewPrefix = (CurrentPrefix + Num) rem K,
        AdjustedPrefix = if NewPrefix < 0 -> NewPrefix + K; true -> NewPrefix end,
        case maps:get(AdjustedPrefix, ModMap, 0) of
            Value ->
                NewCount = CurrentCount + Value,
                NewModMap = maps:update_with(AdjustedPrefix, fun(V) -> V + 1 end, 1, ModMap),
                {NewPrefix, NewCount}
        end
    end, {Prefix, Count}, Nums),
    Result.