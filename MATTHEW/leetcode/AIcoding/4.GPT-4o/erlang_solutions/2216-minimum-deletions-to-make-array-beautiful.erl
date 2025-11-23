-module(solution).
-export([min_deletions/1]).

min_deletions(Array) ->
    N = length(Array),
    min_deletions_helper(Array, N, 0, 0).

min_deletions_helper([], _, _, Deletions) -> 
    Deletions;
min_deletions_helper([H | T], N, Prev, Deletions) ->
    case Prev rem 2 of
        0 when H == Prev -> 
            min_deletions_helper(T, N, H, Deletions + 1);
        _ -> 
            min_deletions_helper(T, N, H, Deletions)
    end.