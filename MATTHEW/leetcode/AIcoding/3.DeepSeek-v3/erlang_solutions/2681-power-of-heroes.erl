-spec max_power(nums :: [integer()]) -> integer().
max_power(Nums) ->
    Sorted = lists:sort(fun(A, B) -> A =< B end, Nums),
    Mod = 1000000007,
    Sum = 0,
    Prev = 0,
    {Result, _, _} = lists:foldl(fun(Cur, {Acc, Sum, Prev}) ->
        NewSum = (Prev + Cur) rem Mod,
        NewAcc = (Acc + (Cur * Cur) rem Mod + (Cur * Sum) rem Mod) rem Mod,
        {NewAcc, (Sum + NewSum) rem Mod, NewSum}
    end, {0, 0, 0}, Sorted),
    Result.