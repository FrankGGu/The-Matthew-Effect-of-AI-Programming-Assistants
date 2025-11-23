-spec partition_disjoint(Nums :: [integer()]) -> integer().
partition_disjoint(Nums) ->
    {LeftMax, TotalMax, Ans} = lists:foldl(fun(N, {LM, TM, A}) ->
        NewLM = max(LM, N),
        NewTM = max(TM, N),
        if
            N < LM -> {NewLM, NewTM, A + 1};
            true -> {NewLM, NewTM, A}
        end
    end, {hd(Nums), hd(Nums), 1}, tl(Nums)),
    Ans.