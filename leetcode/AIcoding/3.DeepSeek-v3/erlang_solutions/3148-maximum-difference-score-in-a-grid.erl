-spec max_score(Grid :: [[integer()]]) -> integer().
max_score(Grid) ->
    M = length(Grid),
    N = length(hd(Grid)),
    DP = lists:duplicate(M, lists:duplicate(N, -1)),
    Max = lists:foldl(
        fun(I, Acc1) ->
            lists:foldl(
                fun(J, Acc2) ->
                    case I > 1 orelse J > 1 of
                        true ->
                            PrevMax = lists:max([
                                if I > 1 -> lists:nth(J, lists:nth(I - 1, DP)); true -> -1 end,
                                if J > 1 -> lists:nth(J - 1, lists:nth(I, DP)); true -> -1 end
                            ]),
                            Current = lists:nth(J, lists:nth(I, Grid)),
                            Score = PrevMax - Current,
                            NewDP = setnth(I, setnth(J, Score, lists:nth(I, DP)), DP),
                            max(Acc2, Score);
                        false ->
                            Acc2
                    end
                end,
                Acc1,
                lists:seq(1, N)
            )
        end,
        -1,
        lists:seq(1, M)
    ),
    Max.

setnth(1, Val, [H|T]) -> [Val|T];
setnth(N, Val, [H|T]) -> [H|setnth(N - 1, Val, T)].