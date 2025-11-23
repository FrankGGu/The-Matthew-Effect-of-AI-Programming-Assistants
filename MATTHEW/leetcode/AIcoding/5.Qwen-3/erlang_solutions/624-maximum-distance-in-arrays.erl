-module(max_distance_in_arrays).
-export([maxDistance/1]).

maxDistance(Arrays) ->
    Min = lists:min([lists:nth(1, A) || A <- Arrays]),
    Max = lists:max([lists:last(A) || A <- Arrays]),
    case {Min, Max} of
        {Min, Max} when Min == Max -> 0;
        _ -> Max - Min
    end.