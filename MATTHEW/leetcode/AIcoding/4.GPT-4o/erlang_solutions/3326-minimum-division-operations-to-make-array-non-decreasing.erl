-module(solution).
-export([min_operations/1]).

min_operations(A) ->
    N = length(A),
    min_operations_helper(A, N, 0).

min_operations_helper([], _, Ops) -> Ops;
min_operations_helper([H | T], N, Ops) ->
    case T of
        [] -> Ops;
        [H2 | _] when H2 < H -> 
            min_operations_helper(T, N, Ops + 1);
        _ -> 
            min_operations_helper(T, N, Ops)
    end.