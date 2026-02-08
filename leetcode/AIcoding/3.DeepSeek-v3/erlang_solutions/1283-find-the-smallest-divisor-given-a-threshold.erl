-spec smallest_divisor(Nums :: [integer()], Threshold :: integer()) -> integer().
smallest_divisor(Nums, Threshold) ->
    Max = lists:max(Nums),
    binary_search(Nums, Threshold, 1, Max).

binary_search(Nums, Threshold, Left, Right) ->
    case Left >= Right of
        true -> Left;
        false ->
            Mid = (Left + Right) div 2,
            Sum = lists:sum([ceil(X / Mid) || X <- Nums]),
            case Sum =< Threshold of
                true -> binary_search(Nums, Threshold, Left, Mid);
                false -> binary_search(Nums, Threshold, Mid + 1, Right)
            end
    end.

ceil(X) ->
    T = X div 1,
    case X - T of
        N when N > 0 -> T + 1;
        _ -> T
    end.