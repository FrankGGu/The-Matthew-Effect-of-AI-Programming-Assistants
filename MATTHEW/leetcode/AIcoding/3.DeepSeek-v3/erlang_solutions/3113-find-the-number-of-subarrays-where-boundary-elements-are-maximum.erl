-spec subarrays_with_max_boundary_elements(Arr :: [integer()]) -> integer().
subarrays_with_max_boundary_elements(Arr) ->
    Max = lists:max(Arr),
    {Count, _} = lists:foldl(fun(Val, {Cnt, Stack}) ->
        case Val =:= Max of
            true -> {Cnt + 1, [1 | Stack]};
            false -> 
                {NewStack, NewCnt} = lists:foldl(fun(X, {S, C}) -> 
                    {[X + 1 | S], C + X + 1} 
                end, {[], Cnt}, Stack),
                {NewCnt, NewStack}
        end
    end, {0, []}, Arr),
    Count.