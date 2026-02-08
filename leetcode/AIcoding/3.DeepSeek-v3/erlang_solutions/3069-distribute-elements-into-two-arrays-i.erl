-spec distribute_array(Nums :: [integer()]) -> [integer()].
distribute_array(Nums) ->
    distribute_array(Nums, [], []).

distribute_array([], Arr1, Arr2) ->
    Arr1 ++ Arr2;
distribute_array([H | T], Arr1, Arr2) ->
    case Arr1 of
        [] -> distribute_array(T, [H], Arr2);
        _ ->
            case Arr2 of
                [] -> distribute_array(T, Arr1, [H]);
                _ ->
                    Last1 = lists:last(Arr1),
                    Last2 = lists:last(Arr2),
                    if
                        Last1 > Last2 -> distribute_array(T, Arr1 ++ [H], Arr2);
                        true -> distribute_array(T, Arr1, Arr2 ++ [H])
                    end
            end
    end.