-module(solution).
-export([min_operations/1]).

min_operations(N) ->
    min_operations(N, 0).

min_operations(0, Acc) ->
    Acc;
min_operations(N, Acc) ->
    case N rem 2 of
        0 ->
            min_operations(N div 2, Acc + 1);
        1 ->
            min_operations((N - 1) div 2, Acc + 2)
    end.