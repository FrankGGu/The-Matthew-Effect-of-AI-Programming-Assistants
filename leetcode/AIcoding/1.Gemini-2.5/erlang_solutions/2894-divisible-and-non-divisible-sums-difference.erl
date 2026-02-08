-module(solution).
-export([differenceOfSums/2]).

differenceOfSums(N, M) ->
    differenceOfSums_helper(1, N, M, 0, 0).

differenceOfSums_helper(Current, N, M, Sum1, Sum2) when Current =< N ->
    case Current rem M of
        0 ->
            differenceOfSums_helper(Current + 1, N, M, Sum1 + Current, Sum2);
        _ ->
            differenceOfSums_helper(Current + 1, N, M, Sum1, Sum2 + Current)
    end;
differenceOfSums_helper(_Current, _N, _M, Sum1, Sum2) ->
    Sum2 - Sum1.