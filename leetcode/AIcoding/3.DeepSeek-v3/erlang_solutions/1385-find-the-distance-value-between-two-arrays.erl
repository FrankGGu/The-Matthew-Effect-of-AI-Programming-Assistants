-spec find_the_distance_value(Arr1 :: [integer()], Arr2 :: [integer()], D :: integer()) -> integer().
find_the_distance_value(Arr1, Arr2, D) ->
    lists:foldl(fun(X, Acc) ->
        case lists:all(fun(Y) -> abs(X - Y) > D end, Arr2) of
            true -> Acc + 1;
            false -> Acc
        end
    end, 0, Arr1).