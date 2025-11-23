-spec count_seniors(Details :: [unicode:unicode_binary()]) -> integer().
count_seniors(Details) ->
    lists:foldl(fun(Detail, Acc) ->
        Age = binary_to_integer(binary:part(Detail, 11, 2)),
        if Age > 60 -> Acc + 1; true -> Acc end
    end, 0, Details).