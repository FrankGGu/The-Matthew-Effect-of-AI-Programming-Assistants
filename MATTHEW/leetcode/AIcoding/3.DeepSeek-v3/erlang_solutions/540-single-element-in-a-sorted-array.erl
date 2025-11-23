-spec single_non_duplicate(Nums :: [integer()]) -> integer().
single_non_duplicate(Nums) ->
    single_non_duplicate(Nums, 0, length(Nums) - 1).

single_non_duplicate(Nums, Left, Right) ->
    if
        Left >= Right -> lists:nth(Left + 1, Nums);
        true ->
            Mid = (Left + Right) div 2,
            if
                Mid rem 2 == 1 ->
                    if
                        lists:nth(Mid, Nums) == lists:nth(Mid - 1, Nums) ->
                            single_non_duplicate(Nums, Mid + 1, Right);
                        true ->
                            single_non_duplicate(Nums, Left, Mid - 1)
                    end;
                true ->
                    if
                        lists:nth(Mid, Nums) == lists:nth(Mid + 1, Nums) ->
                            single_non_duplicate(Nums, Mid + 2, Right);
                        true ->
                            single_non_duplicate(Nums, Left, Mid)
                    end
            end
    end.