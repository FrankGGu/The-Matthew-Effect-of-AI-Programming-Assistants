-spec get_xor_sum(Arr1 :: [integer()], Arr2 :: [integer()]) -> integer().
get_xor_sum(Arr1, Arr2) ->
    Xor1 = lists:foldl(fun(X, Acc) -> X bxor Acc end, 0, Arr1),
    Xor2 = lists:foldl(fun(Y, Acc) -> Y bxor Acc end, 0, Arr2),
    Xor1 band Xor2.