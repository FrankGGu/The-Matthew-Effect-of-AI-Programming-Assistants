-spec maximum_sum_of_heights(MaxHeights :: [integer()]) -> integer().
maximum_sum_of_heights(MaxHeights) ->
    N = length(MaxHeights),
    Left = lists:foldl(fun(I, Acc) ->
        H = lists:nth(I, MaxHeights),
        case I =:= 1 of
            true -> [H];
            false ->
                Prev = lists:nth(I - 1, Acc),
                [min(H, Prev) | Acc]
        end
    end, [], lists:seq(1, N)),
    Left1 = lists:reverse(Left),

    Right = lists:foldr(fun(I, Acc) ->
        H = lists:nth(I, MaxHeights),
        case I =:= N of
            true -> [H];
            false ->
                Next = hd(Acc),
                [min(H, Next) | Acc]
        end
    end, [], lists:seq(1, N)),

    lists:max([lists:sum([min(L, R) || {L, R} <- lists:zip(Left1, Right)])]).