-spec bitwise_nand(N :: integer(), K :: integer()) -> integer().
bitwise_nand(N, K) ->
    case K of
        1 -> 1;
        _ ->
            if
                N == 1 -> 0;
                true ->
                    case bitwise_nand(N - 1, K - 1) bxor bitwise_nand(N - 1, K) of
                        0 -> 0;
                        _ -> 1
                    end
            end
    end.