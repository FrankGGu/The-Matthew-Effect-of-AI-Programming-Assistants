-spec minimum_difference(Scores :: [integer()], K :: integer()) -> integer().
minimum_difference(Scores, K) ->
    Sorted = lists:sort(Scores),
    case length(Sorted) < K of
        true -> 0;
        false ->
            lists:min([lists:nth(I + K - 1, Sorted) - lists:nth(I, Sorted) || I <- lists:seq(1, length(Sorted) - K + 1)])
    end.