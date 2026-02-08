-spec final_array_state(Array :: [integer()], K :: integer()) -> [integer()].
final_array_state(Array, K) ->
    case K of
        0 -> Array;
        _ ->
            Max = lists:max(Array),
            NewArray = lists:map(fun(X) -> if X == Max -> X * 2; true -> X end end, Array),
            final_array_state(NewArray, K - 1)
    end.