-module(solution).
-export([minimum_reverse_operations/3]).

minimum_reverse_operations(N, P, Q) ->
    if
        P == Q -> 0;
        P < Q -> minimum_reverse_operations_helper(N, P, Q, 0);
        true -> minimum_reverse_operations_helper(N, Q, P, 0)
    end.

minimum_reverse_operations_helper(N, P, Q, Steps) ->
    if
        P == Q -> Steps;
        P < Q ->
            case P rem 2 of
                0 -> 
                    minimum_reverse_operations_helper(N, P + 1, Q, Steps + 1);
                1 -> 
                    minimum_reverse_operations_helper(N, P + 1, Q, Steps + 1)
            end;
        true -> 
            minimum_reverse_operations_helper(N, P - 1, Q, Steps + 1)
    end.