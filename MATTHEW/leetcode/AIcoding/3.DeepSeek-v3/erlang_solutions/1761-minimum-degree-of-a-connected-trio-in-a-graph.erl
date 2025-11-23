-spec min_degree_trio(Graph :: [[integer()]]) -> integer().
min_degree_trio(Graph) ->
    N = length(Graph),
    Adj = lists:map(fun(Neighbors) -> sets:from_list(Neighbors) end, Graph),
    MinDegree = lists:foldl(
        fun(I, Acc) ->
            lists:foldl(
                fun(J, InnerAcc) ->
                    case sets:is_element(J, lists:nth(I + 1, Adj)) of
                        true ->
                            lists:foldl(
                                fun(K, InnerInnerAcc) ->
                                    case sets:is_element(K, lists:nth(I + 1, Adj)) andalso sets:is_element(K, lists:nth(J + 1, Adj)) of
                                        true ->
                                            Degree = sets:size(lists:nth(I + 1, Adj)) + sets:size(lists:nth(J + 1, Adj)) + sets:size(lists:nth(K + 1, Adj)) - 6,
                                            min(InnerInnerAcc, Degree);
                                        false ->
                                            InnerInnerAcc
                                    end
                                end,
                                InnerAcc,
                                lists:seq(J + 1, N - 1)
                            );
                        false ->
                            InnerAcc
                    end
                end,
                Acc,
                lists:seq(I + 1, N - 1)
            )
        end,
        infinity,
        lists:seq(0, N - 1)
    ),
    case MinDegree of
        infinity -> -1;
        _ -> MinDegree
    end.