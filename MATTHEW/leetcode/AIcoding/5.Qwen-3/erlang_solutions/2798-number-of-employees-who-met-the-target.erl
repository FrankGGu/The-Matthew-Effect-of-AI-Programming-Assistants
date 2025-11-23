-module(solution).
-export([num_employees_in_target/1]).

num_employees_in_target(Workers) ->
    Target = 5,
    lists:foldl(fun(W, Acc) -> if W >= Target -> Acc + 1; true -> Acc end end, 0, Workers).