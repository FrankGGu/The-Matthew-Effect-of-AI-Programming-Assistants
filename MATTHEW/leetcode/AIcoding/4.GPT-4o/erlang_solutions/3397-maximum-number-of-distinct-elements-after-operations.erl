-module(solution).
-export([maxDistinctElements/2]).

maxDistinctElements(N, A) ->
    Distinct = lists:usort(A),
    CountDistinct = length(Distinct),
    RemainingOps = N - (length(A) - CountDistinct),
    case RemainingOps >= 0 of
        true -> 
            CountDistinct + min(RemainingOps, CountDistinct);
        false -> 
            CountDistinct
    end.