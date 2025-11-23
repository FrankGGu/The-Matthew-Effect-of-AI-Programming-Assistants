-module(solution).
-export([is_possible/3]).

is_possible(A, B, C) ->
    DistinctA = lists:usort(lists:flatten(A)),
    DistinctB = lists:usort(lists:flatten(B)),
    LengthA = length(DistinctA),
    LengthB = length(DistinctB),
    DistinctCount = LengthA + LengthB,
    C >= DistinctCount.