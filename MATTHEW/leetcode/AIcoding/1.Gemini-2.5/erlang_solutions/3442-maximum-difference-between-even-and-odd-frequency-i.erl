-spec solve(Nums :: [integer()]) -> integer().
solve(Nums) ->
    count_parity(Nums, 0, 0).

count_parity([], EvenCount, OddCount) ->
    abs(EvenCount - OddCount);
count_parity([H | T], EvenCount, OddCount) ->
    if
        H rem 2 == 0 ->
            count_parity(T, EvenCount + 1, OddCount);
        true ->
            count_parity(T, EvenCount, OddCount + 1)
    end.