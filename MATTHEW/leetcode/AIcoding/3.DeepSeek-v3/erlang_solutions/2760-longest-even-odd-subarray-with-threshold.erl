-spec longest_alternating_subarray(Nums :: [integer()], Threshold :: integer()) -> integer().
longest_alternating_subarray(Nums, Threshold) ->
    MaxLen = 0,
    CurrentLen = 0,
    lists:foldl(fun(Num, {PrevNum, Current, Max}) ->
        if
            Num > Threshold ->
                {Num, 0, max(Max, Current)};
            Current == 0 ->
                {Num, 1, max(Max, 1)};
            (PrevNum rem 2) =/= (Num rem 2) ->
                {Num, Current + 1, max(Max, Current + 1)};
            true ->
                {Num, 1, max(Max, 1)}
        end
    end, {0, 0, 0}, Nums),
    element(3, lists:foldl(fun(Num, {PrevNum, Current, Max}) ->
        if
            Num > Threshold ->
                {Num, 0, max(Max, Current)};
            Current == 0 ->
                {Num, 1, max(Max, 1)};
            (PrevNum rem 2) =/= (Num rem 2) ->
                {Num, Current + 1, max(Max, Current + 1)};
            true ->
                {Num, 1, max(Max, 1)}
        end
    end, {0, 0, 0}, Nums)).