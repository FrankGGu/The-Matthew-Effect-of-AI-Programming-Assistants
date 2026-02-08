-module(solution).
-export([smaller_numbers_than_current/1]).

smaller_numbers_than_current(List) ->
    Counts = lists:map(fun(X) -> lists:count(fun(Y) -> Y < X end, List) end, List),
    Counts.