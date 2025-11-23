-spec count_triples(N :: integer()) -> integer().
count_triples(N) ->
    count_triples(N, 0).

count_triples(N, Count) when N < 2 ->
    Count;
count_triples(N, Count) ->
    MaxC = N,
    NewCount = lists:foldl(
        fun(C, Acc) ->
            MaxA = trunc(math:sqrt(C * C div 2)),
            lists:foldl(
                fun(A, InnerAcc) ->
                    B = trunc(math:sqrt(C * C - A * A)),
                    if
                        A * A + B * B =:= C * C andalso B >= A andalso B =< N ->
                            InnerAcc + 2;
                        true ->
                            InnerAcc
                    end
                end,
                Acc,
                lists:seq(1, MaxA)
        end,
        Count,
        lists:seq(2, MaxC)),
    NewCount.