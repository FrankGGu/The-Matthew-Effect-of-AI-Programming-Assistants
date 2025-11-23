-spec is_monotonic(Nums :: [integer()]) -> boolean().
is_monotonic(Nums) ->
    case Nums of
        [] -> true;
        [_] -> true;
        _ ->
            {Increasing, Decreasing} = lists:foldl(fun(X, {Inc, Dec}) ->
                case Inc of
                    true -> {X >= element(1, Dec), {X, Dec}};
                    false -> {false, {X, Dec}}
                end
            end, {true, {hd(Nums), true}}, tl(Nums)),
            {_, IsDecreasing} = Decreasing,
            Increasing orelse IsDecreasing
    end.