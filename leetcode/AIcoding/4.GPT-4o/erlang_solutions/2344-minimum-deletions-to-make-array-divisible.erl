-module(solution).
-export([min_deletions/2]).

min_deletions(A, B) ->
    SortedA = lists:sort(A),
    SortedB = lists:sort(B),
    MinDeletions(SortedA, SortedB, 0).

MinDeletions([], _, Deletions) -> 
    Deletions;
MinDeletions(_, [], Deletions) -> 
    -1;
MinDeletions([HA | TA], [HB | TB], Deletions) ->
    case HA rem HB of
        0 -> MinDeletions(TA, TB, Deletions);
        _ -> MinDeletions(TA, [HB | TB], Deletions + 1)
    end.