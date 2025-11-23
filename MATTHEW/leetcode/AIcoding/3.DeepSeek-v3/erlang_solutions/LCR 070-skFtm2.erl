-spec single_non_duplicate(Nums :: [integer()]) -> integer().
single_non_duplicate(Nums) ->
    single_non_duplicate(Nums, 0, length(Nums) - 1).

single_non_duplicate(Nums, Left, Right) ->
    if
        Left >= Right -> lists:nth(Left + 1, Nums);
        true ->
            Mid = Left + (Right - Left) div 2,
            if
                Mid rem 2 == 1 -> 
                    NewMid = Mid - 1;
                true -> 
                    NewMid = Mid
            end,
            if
                lists:nth(NewMid + 1, Nums) == lists:nth(NewMid + 2, Nums) ->
                    single_non_duplicate(Nums, NewMid + 2, Right);
                true ->
                    single_non_duplicate(Nums, Left, NewMid)
            end
    end.