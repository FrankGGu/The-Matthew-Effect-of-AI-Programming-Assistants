-spec distinct_integers(N :: integer()) -> integer().
distinct_integers(N) ->
    case N of
        1 -> 1;
        _ -> N - 1
    end.