-spec count_subarrays(Nums :: [integer()], MinK :: integer(), MaxK :: integer()) -> integer().
count_subarrays(Nums, MinK, MaxK) ->
    {Ans, MinPos, MaxPos, LeftBound} = lists:foldl(
        fun(Num, {Acc, MinP, MaxP, LB}) ->
            NewMinP = if Num =:= MinK -> 0; true -> MinP + 1 end,
            NewMaxP = if Num =:= MaxK -> 0; true -> MaxP + 1 end,
            NewLB = if Num < MinK; Num > MaxK -> -1; true -> LB + 1 end,
            if
                NewLB >= 0 ->
                    NewAcc = Acc + max(0, NewLB - min(NewMinP, NewMaxP)),
                    {NewAcc, NewMinP, NewMaxP, NewLB};
                true ->
                    {Acc, NewMinP, NewMaxP, NewLB}
            end
        end,
        {0, -1, -1, -1},
        Nums
    ),
    Ans.