-spec pivot_integer(N :: integer()) -> integer().
pivot_integer(N) ->
    Total = N * (N + 1) div 2,
    Pivot = trunc(math:sqrt(Total)),
    case Pivot * Pivot == Total of
        true -> Pivot;
        false -> -1
    end.