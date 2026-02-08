-spec minimum_refill(Plants :: [integer()], CapacityA :: integer(), CapacityB :: integer()) -> integer().
minimum_refill(Plants, CapacityA, CapacityB) ->
    {Refills, _, _} = lists:foldl(fun(Plant, {R, A, B}) ->
        case A >= Plant andalso B >= Plant of
            true when A >= B -> {R, A - Plant, B};
            true -> {R, A, B - Plant};
            false when A >= Plant -> {R + 1, CapacityA - Plant, B};
            false when B >= Plant -> {R + 1, A, CapacityB - Plant};
            false -> {R + 2, CapacityA - Plant, CapacityB - Plant}
        end
    end, {0, CapacityA, CapacityB}, Plants),
    Refills.