-module(solution).
-export([min_total_cost/1]).

min_total_cost(Costs) ->
    lists:foldl(fun({A, B}, Acc) -> Acc + abs(A - B) end, 0, Costs).