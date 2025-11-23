-spec smallest_even_multiple(N :: integer()) -> integer().
smallest_even_multiple(N) ->
    case N rem 2 of
        0 -> N;
        _ -> N * 2
    end.