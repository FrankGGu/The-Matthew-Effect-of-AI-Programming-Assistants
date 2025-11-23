-spec maximize_win(prize_positions :: [integer()], k :: integer()) -> integer().
maximize_win(PrizePositions, K) ->
    N = length(PrizePositions),
    Left = lists:duplicate(N, 0),
    Right = lists:duplicate(N, 0),
    {Left1, _} = lists:foldl(fun(I, {Acc, J}) ->
        while_loop(I, J, PrizePositions, K, Acc)
    end, {Left, 0}, lists:seq(0, N - 1)),
    {Right1, _} = lists:foldr(fun(I, {Acc, J}) ->
        while_loop_rev(I, J, PrizePositions, K, Acc)
    end, {Right, N - 1}, lists:seq(N - 1, 0, -1)),
    lists:foldl(fun(I, Max) ->
        case I + 1 < N of
            true -> max(Max, lists:nth(I + 1, Left1) + lists:nth(I + 2, Right1));
            false -> Max
        end
    end, 0, lists:seq(0, N - 1)).

while_loop(I, J, PrizePositions, K, Acc) ->
    case J < length(PrizePositions) andalso (lists:nth(J + 1, PrizePositions) - lists:nth(I + 1, PrizePositions) =< K) of
        true -> while_loop(I, J + 1, PrizePositions, K, Acc);
        false ->
            NewAcc = case I > 0 of
                true -> setelement(I + 1, Acc, max(lists:nth(I, Acc), J - I));
                false -> setelement(I + 1, Acc, J - I)
            end,
            {NewAcc, J}
    end.

while_loop_rev(I, J, PrizePositions, K, Acc) ->
    case J >= 0 andalso (lists:nth(I + 1, PrizePositions) - lists:nth(J + 1, PrizePositions) =< K of
        true -> while_loop_rev(I, J - 1, PrizePositions, K, Acc);
        false ->
            NewAcc = case I + 1 < length(PrizePositions) of
                true -> setelement(I + 1, Acc, max(lists:nth(I + 2, Acc), I - J));
                false -> setelement(I + 1, Acc, I - J)
            end,
            {NewAcc, J}
    end.