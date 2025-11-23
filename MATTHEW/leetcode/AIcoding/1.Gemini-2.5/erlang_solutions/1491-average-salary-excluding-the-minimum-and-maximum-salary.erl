-module(solution).
-export([average/1]).

average(Salary) ->
    Min = lists:min(Salary),
    Max = lists:max(Salary),
    SalaryWithoutMin = lists:delete(Min, Salary),
    SalaryWithoutMinMax = lists:delete(Max, SalaryWithoutMin),
    Sum = lists:sum(SalaryWithoutMinMax),
    Count = length(SalaryWithoutMinMax),
    Sum / Count.