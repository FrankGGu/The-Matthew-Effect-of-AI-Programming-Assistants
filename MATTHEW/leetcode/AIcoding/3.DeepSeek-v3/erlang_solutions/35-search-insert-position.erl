-spec search_insert(Nums :: [integer()], Target :: integer()) -> integer().
search_insert(Nums, Target) ->
    search_insert(Nums, Target, 0, length(Nums) - 1).

search_insert(Nums, Target, Left, Right) when Left =< Right ->
    Mid = Left + (Right - Left) div 2,
    MidVal = lists:nth(Mid + 1, Nums),
    if
        MidVal =:= Target -> Mid;
        MidVal < Target -> search_insert(Nums, Target, Mid + 1, Right);
        true -> search_insert(Nums, Target, Left, Mid - 1)
    end;
search_insert(_, _, Left, _) -> Left.