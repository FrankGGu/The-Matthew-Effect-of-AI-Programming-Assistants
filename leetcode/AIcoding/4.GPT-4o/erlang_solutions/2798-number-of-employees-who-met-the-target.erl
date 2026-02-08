-module(solution).
-export([num_employees_meeting_target/2]).

num_employees_meeting_target(Target, Hours) ->
    lists:foldl(fun(Hour, Acc) -> if Hour >= Target -> Acc + 1; true -> Acc end end, 0, Hours).