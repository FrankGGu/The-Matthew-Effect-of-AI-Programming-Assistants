-module(solution).
-export([sum_of_power/1]).

sum_of_power(N) when is_list(N) ->
    Total = lists:sum(lists:map(fun(X) -> power_sum(X) end, N)),
    Total rem (math:pow(10, 9) + 7).

power_sum(X) ->
    (2 * X) rem (math:pow(10, 9) + 7).