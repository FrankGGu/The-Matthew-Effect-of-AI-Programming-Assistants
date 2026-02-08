-module(solution).
-export([median_of_uniqueness/1]).

median_of_uniqueness(A) ->
    Unique = lists:usort(A),
    N = length(Unique),
    Mid = N div 2,
    if
        N rem 2 == 0 -> lists:nth(Mid + 1, Unique);
        true -> lists:nth(Mid + 1, Unique)
    end.