-module(solution).
-export([sum_of_three/1]).

sum_of_three(N) ->
    case N rem 3 of
        0 -> [N div 3 - 1, N div 3, N div 3 + 1];
        _ -> []
    end.