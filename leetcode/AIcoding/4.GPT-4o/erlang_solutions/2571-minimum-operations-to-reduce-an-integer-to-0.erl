-module(solution).
-export([min_operations/1]).

min_operations(N) when N < 0 -> 0;
min_operations(0) -> 0;
min_operations(N) -> min_operations_helper(N, 0).

min_operations_helper(0, Steps) -> Steps;
min_operations_helper(N, Steps) ->
    case N rem 2 of
        0 -> min_operations_helper(N div 2, Steps + 1);
        _ -> min_operations_helper(N - 1, Steps + 1)
    end.