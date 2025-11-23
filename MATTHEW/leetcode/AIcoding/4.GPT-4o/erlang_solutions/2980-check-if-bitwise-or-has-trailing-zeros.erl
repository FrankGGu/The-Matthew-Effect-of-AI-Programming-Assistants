-module(solution).
-export([hasTrailingZeros/1]).

hasTrailingZeros(N) ->
    case N of
        0 -> false;
        _ -> (N band 1) =:= 0
    end.