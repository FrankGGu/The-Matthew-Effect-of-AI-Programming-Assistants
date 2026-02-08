-spec find_peak_element(Nums :: [integer()]) -> integer().
find_peak_element(Nums) ->
    find_peak(Nums, 0, length(Nums) - 1).

find_peak([H|_], 0, 0) -> 0;
find_peak([H|T], Left, Right) when Left == Right -> Left;
find_peak(Nums, Left, Right) ->
    Mid = (Left + Right) div 2,
    case lists:nth(Mid + 1, Nums) > lists:nth(Mid + 2, Nums) of
        true -> find_peak(Nums, Left, Mid);
        false -> find_peak(Nums, Mid + 1, Right)
    end.