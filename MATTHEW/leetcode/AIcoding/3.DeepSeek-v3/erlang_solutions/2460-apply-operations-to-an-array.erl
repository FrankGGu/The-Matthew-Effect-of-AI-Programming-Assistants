-spec apply_operations(Nums :: [integer()]) -> [integer()].
apply_operations(Nums) ->
    Modified = apply_operations_helper(Nums, []),
    Zeros = lists:filter(fun(X) -> X =:= 0 end, Modified),
    NonZeros = lists:filter(fun(X) -> X =/= 0 end, Modified),
    NonZeros ++ Zeros.

apply_operations_helper([], Acc) -> lists:reverse(Acc);
apply_operations_helper([X], Acc) -> lists:reverse([X | Acc]);
apply_operations_helper([X, Y | Rest], Acc) ->
    if
        X =:= Y ->
            apply_operations_helper([X + Y, 0 | Rest], Acc);
        true ->
            apply_operations_helper([Y | Rest], [X | Acc])
    end.