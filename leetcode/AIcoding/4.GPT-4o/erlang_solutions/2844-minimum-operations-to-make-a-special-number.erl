-module(solution).
-export([min_operations/1]).

min_operations(Number) ->
    Str = integer_to_list(Number),
    MinOps = calculate(Str, 0),
    MinOps.

calculate([], Ops) -> Ops;
calculate([H | T], Ops) ->
    NewOps = case (H - $0) rem 2 of
                 0 -> Ops;
                 _ -> Ops + 1
               end,
    calculate(T, NewOps).