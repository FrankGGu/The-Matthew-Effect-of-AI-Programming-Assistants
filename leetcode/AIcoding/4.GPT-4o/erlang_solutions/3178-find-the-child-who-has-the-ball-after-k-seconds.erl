-module(solution).
-export([find_child/2]).

find_child(N, K) ->
    case N rem 2 of
        0 -> (K rem (2 * N)) div 2 + 1;
        _ -> (K rem (2 * (N - 1))) div 2 + 1 + (if K rem (2 * (N - 1)) < N - 1 -> 0; true -> 1 end)
    end.