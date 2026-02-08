-module(solution).
-export([min_operations/1]).

min_operations(Array) ->
    MinOps = calculate(Array, 0),
    MinOps.

calculate([], Acc) ->
    Acc;
calculate([H | T], Acc) ->
    case T of
        [] -> Acc;
        [Next | _] when H > Next -> 
            calculate([H + 1 | T], Acc + 1);
        _ -> 
            calculate(T, Acc)
    end.