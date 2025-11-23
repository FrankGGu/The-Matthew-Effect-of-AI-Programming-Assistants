-spec search_range(Nums :: [integer()], Target :: integer()) -> [integer()].
search_range(Nums, Target) ->
    case binary_search(Nums, Target, 0, length(Nums) - 1) of
        -1 -> [-1, -1];
        Pos ->
            Start = find_first(Nums, Target, 0, Pos),
            End = find_last(Nums, Target, Pos, length(Nums) - 1),
            [Start, End]
    end.

binary_search(Nums, Target, Left, Right) when Left =< Right ->
    Mid = Left + (Right - Left) div 2,
    case lists:nth(Mid + 1, Nums) of
        Val when Val < Target -> binary_search(Nums, Target, Mid + 1, Right);
        Val when Val > Target -> binary_search(Nums, Target, Left, Mid - 1);
        _ -> Mid
    end;
binary_search(_, _, _, _) -> -1.

find_first(Nums, Target, Left, Right) ->
    case binary_search(Nums, Target, Left, Right) of
        -1 -> Right + 1;
        Pos -> find_first(Nums, Target, Left, Pos - 1)
    end.

find_last(Nums, Target, Left, Right) ->
    case binary_search(Nums, Target, Left, Right) of
        -1 -> Left - 1;
        Pos -> find_last(Nums, Target, Pos + 1, Right)
    end.