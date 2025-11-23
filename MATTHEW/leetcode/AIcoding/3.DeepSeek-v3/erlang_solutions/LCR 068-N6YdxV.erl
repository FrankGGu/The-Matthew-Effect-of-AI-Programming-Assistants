-spec search_insert(Nums :: [integer()], Target :: integer()) -> integer().
search_insert(Nums, Target) ->
    search_insert(Nums, Target, 0, length(Nums) - 1).

search_insert(Nums, Target, Left, Right) when Left =< Right ->
    Mid = Left + (Right - Left) div 2,
    case lists:nth(Mid + 1, Nums) of
        Num when Num =:= Target -> Mid;
        Num when Num < Target -> search_insert(Nums, Target, Mid + 1, Right);
        _ -> search_insert(Nums, Target, Left, Mid - 1)
    end;
search_insert(_, Target, Left, _) -> Left.