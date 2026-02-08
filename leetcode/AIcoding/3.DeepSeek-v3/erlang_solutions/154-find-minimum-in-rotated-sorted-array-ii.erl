-spec find_min(Nums :: [integer()]) -> integer().
find_min(Nums) ->
    find_min(Nums, 0, length(Nums) - 1).

find_min([H|_], Low, High) when Low >= High ->
    H;
find_min(Nums, Low, High) ->
    Mid = (Low + High) div 2,
    case lists:nth(Mid + 1, Nums) > lists:nth(High + 1, Nums) of
        true -> find_min(Nums, Mid + 1, High);
        false ->
            case lists:nth(Mid + 1, Nums) < lists:nth(High + 1, Nums) of
                true -> find_min(Nums, Low, Mid);
                false -> find_min(Nums, Low, High - 1)
            end
    end.