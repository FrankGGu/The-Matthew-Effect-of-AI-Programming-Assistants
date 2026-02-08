-module(solution).
-export([smallest_number/1]).

smallest_number(N) ->
    case N of
        0 -> 0;
        _ -> (1 bsl N) - 1
    end.