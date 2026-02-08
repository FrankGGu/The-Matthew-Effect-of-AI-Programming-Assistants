-module(solution).
-export([preimage_size_fzf/1]).

preimage_size_fzf(N) ->
    case N rem 5 of
        0 -> 5;
        _ -> 0
    end.