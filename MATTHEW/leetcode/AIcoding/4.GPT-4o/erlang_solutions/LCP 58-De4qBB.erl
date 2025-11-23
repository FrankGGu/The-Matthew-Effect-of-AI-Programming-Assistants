-module(solution).
-export([build_blocks/1]).

build_blocks(N) ->
    case N rem 2 of
        0 -> N div 2 * N div 2;
        _ -> (N div 2) * (N div 2 + 1)
    end.