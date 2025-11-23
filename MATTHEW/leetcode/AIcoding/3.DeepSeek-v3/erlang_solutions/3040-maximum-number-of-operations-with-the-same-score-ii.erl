-spec max_operations(Nums :: [integer()]) -> integer().
max_operations(Nums) ->
    N = length(Nums),
    if
        N < 2 -> 0;
        true ->
            Options = [
                {lists:nth(1, Nums) + lists:nth(2, Nums), 1, 2},
                {lists:nth(1, Nums) + lists:nth(N, Nums), 1, N},
                {lists:nth(N - 1, Nums) + lists:nth(N, Nums), N - 1, N}
            ],
            UniqueSums = lists:usort([Sum || {Sum, _, _} <- Options]),
            lists:max([solve(Nums, Sum) || Sum <- UniqueSums])
    end.

solve(Nums, Sum) ->
    solve(Nums, Sum, 0, 1, length(Nums)).

solve(Nums, Sum, Count, Left, Right) when Left >= Right ->
    Count;
solve(Nums, Sum, Count, Left, Right) ->
    case lists:nth(Left, Nums) + lists:nth(Right, Nums) of
        Sum ->
            solve(Nums, Sum, Count + 1, Left + 1, Right - 1);
        _ ->
            LeftSum = lists:nth(Left, Nums) + lists:nth(Left + 1, Nums),
            RightSum = lists:nth(Right - 1, Nums) + lists:nth(Right, Nums),
            if
                LeftSum == Sum ->
                    solve(Nums, Sum, Count + 1, Left + 2, Right);
                RightSum == Sum ->
                    solve(Nums, Sum, Count + 1, Left, Right - 2);
                true ->
                    Count
            end
    end.