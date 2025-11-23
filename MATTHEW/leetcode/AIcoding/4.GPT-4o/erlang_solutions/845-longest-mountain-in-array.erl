-module(solution).
-export([longest_mountain/1]).

longest_mountain([]) -> 0;
longest_mountain(A) ->
    N = length(A),
    longest_mountain_helper(A, N, 0, 0, 0).

longest_mountain_helper(A, N, i, up, down) when i >= N -> 
    max(up + down + 1, 0);
longest_mountain_helper(A, N, i, up, down) ->
    case lists:nth(i + 1, A) - lists:nth(i, A) of
        X when X > 0 -> longest_mountain_helper(A, N, i + 1, up + 1, down);
        X when X < 0 -> longest_mountain_helper(A, N, i + 1, 0, down + 1);
        _ -> longest_mountain_helper(A, N, i + 1, 0, 0)
    end.