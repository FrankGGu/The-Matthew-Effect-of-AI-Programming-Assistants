-spec count_descent_periods(Prices :: [integer()]) -> integer().
count_descent_periods(Prices) ->
    {Total, Current} = lists:foldl(fun
        (Price, {Sum, PrevCount, PrevPrice}) when Price =:= PrevPrice - 1 ->
            NewCount = PrevCount + 1,
            {Sum + NewCount, NewCount, Price};
        (Price, {Sum, _PrevCount, _PrevPrice}) ->
            {Sum + 1, 1, Price}
    end, {0, 0, 0}, Prices),
    Total.