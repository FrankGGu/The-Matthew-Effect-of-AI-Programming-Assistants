-module(solution).
-export([minOperations/1]).

minOperations(N) ->
    case N rem 2 of
        0 -> % N is even
            (N div 2) * (N div 2);
        1 -> % N is odd
            ((N - 1) div 2) * ((N + 1) div 2)
    end.