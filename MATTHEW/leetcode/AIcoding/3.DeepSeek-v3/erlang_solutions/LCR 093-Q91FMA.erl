-spec len_longest_fib_subseq(Arr :: [integer()]) -> integer().
len_longest_fib_subseq(Arr) ->
    N = length(Arr),
    IndexMap = maps:from_list([{lists:nth(I, Arr), I} || I <- lists:seq(1, N)]),
    DP = lists:foldl(fun(_, Acc) -> Acc ++ [maps:new()] end, [], lists:seq(1, N)),
    MaxLen = 0,
    {Ans, _, _} = lists:foldl(
        fun(K, {AnsAcc, DPAcc, IndexMapAcc}) ->
            lists:foldl(
                fun(J, {AnsIn, DPIn, IndexMapIn}) ->
                    case maps:get(lists:nth(K, Arr) - lists:nth(J, Arr), IndexMapIn, undefined) of
                        undefined ->
                            {AnsIn, DPIn, IndexMapIn};
                        I ->
                            Val = maps:get(I, DPIn, maps:new()),
                            Len = maps:get(J, Val, 2) + 1,
                            NewDP = DPIn#{K => maps:put(J, Len, maps:get(K, DPIn, maps:new()))},
                            {max(AnsIn, Len), NewDP, IndexMapIn}
                    end
                end,
                {AnsAcc, DPAcc, IndexMapAcc},
                lists:seq(1, J - 1)
            )
        end,
        {MaxLen, DP, IndexMap},
        lists:seq(3, N)
    ),
    if Ans >= 3 -> Ans; true -> 0 end.