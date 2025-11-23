-spec maximum_subarray_sum(Nums :: [integer()], K :: integer()) -> integer().
maximum_subarray_sum(Nums, K) ->
    {Window, Sum, Max, Map} = lists:foldl(fun
        (Num, {[Old | Rest], CurrentSum, CurrentMax, CurrentMap}) when length([Old | Rest]) =:= K ->
            NewSum = CurrentSum - Old + Num,
            NewMap1 = maps:update_with(Old, fun(V) -> V - 1 end, CurrentMap),
            NewMap2 = case maps:get(Old, NewMap1, 0) of
                0 -> maps:remove(Old, NewMap1);
                _ -> NewMap1
            end,
            NewMap3 = maps:update_with(Num, fun(V) -> V + 1 end, 1, NewMap2),
            case maps:size(NewMap3) =:= K of
                true -> {Rest ++ [Num], NewSum, max(CurrentMax, NewSum), NewMap3};
                false -> {Rest ++ [Num], NewSum, CurrentMax, NewMap3}
            end;
        (Num, {Window, CurrentSum, CurrentMax, CurrentMap}) ->
            NewSum = CurrentSum + Num,
            NewMap = maps:update_with(Num, fun(V) -> V + 1 end, 1, CurrentMap),
            {Window ++ [Num], NewSum, CurrentMax, NewMap}
    end, {[], 0, 0, maps:new()}, Nums),
    case length(Window) =:= K andalso maps:size(Map) =:= K of
        true -> max(Max, Sum);
        false -> Max
    end.