-spec bitwise_complement(N :: integer()) -> integer().
bitwise_complement(N) ->
    case N of
        0 -> 1;
        _ ->
            Mask = 1,
            bitwise_complement(N, Mask)
    end.

bitwise_complement(N, Mask) ->
    case Mask < N of
        true -> bitwise_complement(N, (Mask bsl 1) bor 1);
        false -> Mask bxor N
    end.