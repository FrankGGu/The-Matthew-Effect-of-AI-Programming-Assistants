-spec max_satisfied(Customers :: [integer()], Grumpy :: [integer()], X :: integer()) -> integer().
max_satisfied(Customers, Grumpy, X) ->
    N = length(Customers),
    Total = lists:sum([C || {C, G} <- lists:zip(Customers, Grumpy), G == 0]),
    MaxIncrease = 0,
    CurrentIncrease = 0,
    {MaxIncrease, _} = lists:foldl(fun(I, {MaxInc, CurrInc}) ->
        CurrInc1 = if
            I >= X ->
                G = lists:nth(I - X + 1, Grumpy),
                C = lists:nth(I - X + 1, Customers),
                CurrInc - (C * G);
            true ->
                CurrInc
        end,
        G = lists:nth(I + 1, Grumpy),
        C = lists:nth(I + 1, Customers),
        CurrInc2 = CurrInc1 + (C * G),
        NewMaxInc = max(MaxInc, CurrInc2),
        {NewMaxInc, CurrInc2}
    end, {MaxIncrease, CurrentIncrease}, lists:seq(0, N - X)),
    Total + MaxIncrease.