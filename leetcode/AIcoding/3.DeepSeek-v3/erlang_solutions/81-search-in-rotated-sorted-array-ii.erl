-spec search(Nums :: [integer()], Target :: integer()) -> boolean().
search(Nums, Target) ->
    search(Nums, Target, 0, length(Nums) - 1).

search([], _, _, _) -> false;
search(Nums, Target, Left, Right) when Left =< Right ->
    Mid = Left + (Right - Left) div 2,
    MidVal = lists:nth(Mid + 1, Nums),
    if
        MidVal =:= Target -> true;
        true ->
            LeftVal = lists:nth(Left + 1, Nums),
            RightVal = lists:nth(Right + 1, Nums),
            if
                LeftVal < MidVal ->
                    if
                        Target >= LeftVal, Target < MidVal ->
                            search(Nums, Target, Left, Mid - 1);
                        true ->
                            search(Nums, Target, Mid + 1, Right)
                    end;
                MidVal < RightVal ->
                    if
                        Target > MidVal, Target =< RightVal ->
                            search(Nums, Target, Mid + 1, Right);
                        true ->
                            search(Nums, Target, Left, Mid - 1)
                    end;
                true ->
                    case search(Nums, Target, Left, Mid - 1) of
                        true -> true;
                        false -> search(Nums, Target, Mid + 1, Right)
                    end
            end
    end;
search(_, _, _, _) -> false.