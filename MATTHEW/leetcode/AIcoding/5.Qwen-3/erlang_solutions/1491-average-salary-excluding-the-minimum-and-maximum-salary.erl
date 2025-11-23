-module(salary).
-export([average/1]).

average(Salaries) ->
    Min = lists:min(Salaries),
    Max = lists:max(Salaries),
    Sum = lists:sum(Salaries) - Min - Max,
    Length = length(Salaries) - 2,
    Sum / Length.