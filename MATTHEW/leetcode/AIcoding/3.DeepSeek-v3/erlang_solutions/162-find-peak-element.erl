-spec find_peak_element(Nums :: [integer()]) -> integer().
find_peak_element(Nums) ->
    find_peak_element(Nums, 0, length(Nums) - 1).

find_peak_element(Nums, Left, Right) ->
    if
        Left == Right ->
            Left;
        true ->
            Mid = (Left + Right) div 2,
            if
                lists:nth(Mid + 1, Nums) > lists:nth(Mid + 2, Nums) ->
                    find_peak_element(Nums, Left, Mid);
                true ->
                    find_peak_element(Nums, Mid + 1, Right)
            end
    end.