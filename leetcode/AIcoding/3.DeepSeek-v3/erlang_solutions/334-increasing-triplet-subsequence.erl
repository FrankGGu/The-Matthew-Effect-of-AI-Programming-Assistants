-spec increasing_triplet(Nums :: [integer()]) -> boolean().
increasing_triplet(Nums) ->
    First = infinity,
    Second = infinity,
    check_triplet(Nums, First, Second).

check_triplet([], _First, _Second) -> false;
check_triplet([Num | Rest], First, Second) ->
    if
        Num =< First -> check_triplet(Rest, Num, Second);
        Num =< Second -> check_triplet(Rest, First, Num);
        true -> true
    end.