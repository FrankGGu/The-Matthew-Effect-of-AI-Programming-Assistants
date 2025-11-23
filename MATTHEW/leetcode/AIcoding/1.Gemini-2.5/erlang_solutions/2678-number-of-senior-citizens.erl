-spec count_seniors(Details :: [string()]) -> integer().
count_seniors(Details) ->
    lists:foldl(fun(Detail, Acc) ->
                    AgeStr = string:substr(Detail, 12, 2),
                    Age = list_to_integer(AgeStr),
                    if Age > 60 -> Acc + 1;
                       true -> Acc
                    end
                end, 0, Details).