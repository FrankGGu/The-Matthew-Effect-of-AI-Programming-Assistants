-spec find_error_nums(Nums :: [integer()]) -> [integer()].
find_error_nums(Nums) ->
    Sorted = lists:sort(Nums),
    {Dup, Sum} = find_dup_and_sum(Sorted, 0, 0, 0),
    N = length(Nums),
    ExpectedSum = N * (N + 1) div 2,
    Missing = ExpectedSum - Sum + Dup,
    [Dup, Missing].

find_dup_and_sum([], Dup, Sum, _) -> {Dup, Sum};
find_dup_and_sum([H | T], Dup, Sum, Prev) ->
    if
        H =:= Prev -> find_dup_and_sum(T, H, Sum, H);
        true -> find_dup_and_sum(T, Dup, Sum + H, H)
    end.