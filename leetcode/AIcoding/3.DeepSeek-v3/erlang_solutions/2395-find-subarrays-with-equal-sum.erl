-spec find_subarrays(Nums :: [integer()]) -> boolean().
find_subarrays(Nums) ->
    Sums = sets:new(),
    find_subarrays(Nums, Sums).

find_subarrays([A, B | Rest], Sums) ->
    Sum = A + B,
    case sets:is_element(Sum, Sums) of
        true -> true;
        false ->
            NewSums = sets:add_element(Sum, Sums),
            find_subarrays([B | Rest], NewSums)
    end;
find_subarrays(_, _) -> false.