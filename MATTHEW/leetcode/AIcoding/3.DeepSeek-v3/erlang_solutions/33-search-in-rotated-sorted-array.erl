-spec search(Nums :: [integer()], Target :: integer()) -> integer().
search(Nums, Target) ->
    search(Nums, Target, 0, length(Nums) - 1).

search(Nums, Target, Left, Right) when Left =< Right ->
    Mid = Left + (Right - Left) div 2,
    MidVal = lists:nth(Mid + 1, Nums),
    case lists:nth(Left + 1, Nums) =< MidVal of
        true ->
            if
                lists:nth(Left + 1, Nums) =< Target andalso Target =< MidVal ->
                    search(Nums, Target, Left, Mid);
                true ->
                    search(Nums, Target, Mid + 1, Right)
            end;
        false ->
            if
                MidVal =< Target andalso Target =< lists:nth(Right + 1, Nums) ->
                    search(Nums, Target, Mid, Right);
                true ->
                    search(Nums, Target, Left, Mid - 1)
            end
    end;
search(_, _, _, _) -> -1.