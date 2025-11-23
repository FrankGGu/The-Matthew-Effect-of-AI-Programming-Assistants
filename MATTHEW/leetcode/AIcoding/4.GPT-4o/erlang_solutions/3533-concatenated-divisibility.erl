-module(solution).
-export([concatenated_divisibility/2]).

concatenated_divisibility(N, K) ->
    concat(N, 1) rem K == 0.

concat(N, Multiplier) ->
    case Multiplier > N of
        true -> 0;
        false -> 
            concat(N, Multiplier + 1) + (N * 10^(Multiplier - 1))
    end.