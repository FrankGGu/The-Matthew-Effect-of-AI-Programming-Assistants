-spec does_valid_array_exist(Derived :: [integer()]) -> boolean().
does_valid_array_exist(Derived) ->
    N = length(Derived),
    case N of
        1 -> Derived == [0];
        _ ->
            lists:foldl(fun(_, Acc) -> Acc bxor 1 end, 0, Derived) == 0
    end.