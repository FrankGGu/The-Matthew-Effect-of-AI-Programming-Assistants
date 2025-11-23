-spec painting_plan(N :: integer(), K :: integer()) -> integer().
painting_plan(N, K) ->
    case K of
        0 -> 1;
        K when K == N * N -> 1;
        _ ->
            Res = 0,
            lists:foldl(
                fun(I, Acc) ->
                    lists:foldl(
                        fun(J, Acc1) ->
                            case I * N + J * N - I * J of
                                K -> Acc1 + comb(N, I) * comb(N, J);
                                _ -> Acc1
                            end
                        end,
                        Acc,
                        lists:seq(0, N)
                    )
                end,
                Res,
                lists:seq(0, N)
            )
    end.

comb(N, K) when K > N -> 0;
comb(_, 0) -> 1;
comb(N, K) ->
    comb(N - 1, K - 1) * N div K.