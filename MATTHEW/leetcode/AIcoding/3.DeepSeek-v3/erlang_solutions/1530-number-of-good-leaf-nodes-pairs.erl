-spec count_pairs(Root :: #tree_node{} | null, Distance :: integer()) -> integer().
count_pairs(Root, Distance) ->
    {Count, _} = dfs(Root, Distance),
    Count div 2.

dfs(null, _) ->
    {0, []};
dfs(#tree_node{left = null, right = null}, _) ->
    {0, [0]};
dfs(#tree_node{left = Left, right = Right}, Distance) ->
    {CountL, ListL} = dfs(Left, Distance),
    {CountR, ListR} = dfs(Right, Distance),
    Count = CountL + CountR,
    NewList = [],
    CountPairs = count_pairs(ListL, ListR, Distance, 0, NewList),
    MergedList = merge_lists(ListL, ListR, NewList),
    {Count + CountPairs, MergedList}.

count_pairs([], _, _, Acc, NewList) ->
    Acc;
count_pairs([H | T], ListR, Distance, Acc, NewList) ->
    NewAcc = lists:foldl(fun(R, Sum) ->
        if
            H + R + 1 =< Distance -> Sum + 1;
            true -> Sum
        end
    end, Acc, ListR),
    count_pairs(T, ListR, Distance, NewAcc, [H + 1 | NewList]).

merge_lists([], [], NewList) ->
    NewList;
merge_lists([], R, NewList) ->
    lists:map(fun(X) -> X + 1 end, R) ++ NewList;
merge_lists(L, [], NewList) ->
    lists:map(fun(X) -> X + 1 end, L) ++ NewList;
merge_lists([LH | LT], [RH | RT], NewList) ->
    if
        LH + 1 =< RH + 1 ->
            merge_lists(LT, [RH | RT], [LH + 1 | NewList]);
        true ->
            merge_lists([LH | LT], RT, [RH + 1 | NewList])
    end.