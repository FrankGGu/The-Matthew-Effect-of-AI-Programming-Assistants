-spec largest_altitude(Gain :: [integer()]) -> integer().
largest_altitude(Gain) ->
    lists:max([0 | lists:foldl(fun(X, Acc) -> [hd(Acc) + X | Acc] end, [0], Gain)]).