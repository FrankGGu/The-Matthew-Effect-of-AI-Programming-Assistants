-module(solution).
-export([max_element_sum/1]).

max_element_sum(Numbers) ->
    Max = lists:max(Numbers),
    Sum = lists:foldl(fun(N, Acc) -> Acc + N end, 0, Numbers),
    Sum.