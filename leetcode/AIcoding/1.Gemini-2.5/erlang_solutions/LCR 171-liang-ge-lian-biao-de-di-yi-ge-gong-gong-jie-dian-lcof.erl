-module(solution).
-export([count_senior_citizens/1]).

-spec count_senior_citizens(Details :: [string()]) -> integer().
count_senior_citizens(Details) ->
    lists:foldl(fun(Detail, Acc) ->
                    AgeStr = lists:sublist(Detail, 12, 2),
                    Age = list_to_integer(AgeStr),
                    if Age > 60 -> Acc + 1;
                       true -> Acc
                    end
                end, 0, Details).