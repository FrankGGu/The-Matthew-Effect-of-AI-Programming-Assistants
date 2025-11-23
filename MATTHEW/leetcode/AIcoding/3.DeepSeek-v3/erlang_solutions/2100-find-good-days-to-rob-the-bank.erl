-spec good_days_to_rob_bank(Security :: [integer()], Time :: integer()) -> [integer()].
good_days_to_rob_bank(Security, Time) ->
    N = length(Security),
    Left = lists:duplicate(N, 0),
    Right = lists:duplicate(N, 0),
    {Left1, _} = lists:foldl(fun(I, {Acc, Prev}) ->
        case I > 0 andalso lists:nth(I, Security) =< lists:nth(I + 1, Security) of
            true -> {lists:sublist(Acc, I - 1) ++ [Prev + 1], Prev + 1};
            false -> {lists:sublist(Acc, I - 1) ++ [0], 0}
        end
    end, {Left, 0}, lists:seq(1, N - 1)),
    {Right1, _} = lists:foldr(fun(I, {Acc, Prev}) ->
        case I < N andalso lists:nth(I, Security) >= lists:nth(I + 1, Security) of
            true -> {[Prev + 1 | lists:nthtail(I, Acc)], Prev + 1};
            false -> {[0 | lists:nthtail(I, Acc)], 0}
        end
    end, {Right, 0}, lists:seq(1, N - 1)),
    lists:filtermap(fun(I) ->
        case lists:nth(I, Left1) >= Time andalso lists:nth(I, Right1) >= Time of
            true -> {true, I - 1};
            false -> false
        end
    end, lists:seq(1, N)).