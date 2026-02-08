-spec max_jump(stones :: [integer()]) -> integer().
max_jump(Stones) ->
    N = length(Stones),
    if
        N == 2 -> lists:nth(2, Stones) - lists:nth(1, Stones);
        true ->
            Max = 0,
            lists:foldl(fun(I, Acc) ->
                Jump = max(lists:nth(I + 1, Stones) - lists:nth(I - 1, Stones), Acc),
                max(Jump, Acc)
            end, Max, lists:seq(2, N - 1))
    end.