-module(solution).
-export([maximum_points/3]).

maximum_points(Edges, CoinsList, K) ->
    N = length(CoinsList),
    Adj = build_adj(N, Edges),
    CoinsTuple = list_to_tuple(CoinsList),
    {Result, _FinalMemo} = dfs(0, -1, 0, Adj, CoinsTuple, K, gb_trees:empty()),
    Result.

build_adj(N, Edges) ->
    InitialAdj = maps:from_list([{I, []} || I <- lists:seq(0, N - 1)]),
    lists:foldl(
        fun({U, V}, Acc) ->
            maps:update_with(U, fun(List) -> [V | List] end, [V], Acc),
            maps:update_with(V, fun(List) -> [U | List] end, [U], Acc)
        end,
        InitialAdj,
        Edges
    ).

dfs(U, Parent, HalvedCount, Adj, CoinsTuple, K, Memo) ->
    case gb_trees:lookup({U, HalvedCount}, Memo) of
        {value, Result} -> {Result, Memo};
        none ->
            CurrentCoins = element(U + 1, CoinsTuple),
            EffectiveCoins = CurrentCoins bsr HalvedCount,

            PointsFromU = max(0, EffectiveCoins - K),

            {ChildrenPoints1, Memo1} = collect_children_points(
                                            maps:get(U, Adj),
                                            U, Parent, HalvedCount, Adj, CoinsTuple, K, Memo
                                       ),
            TotalPoints1 = PointsFromU + ChildrenPoints1,

            {ChildrenPoints2, Memo2} = collect_children_points(
                                            maps:get(U, Adj),
                                            U, Parent, HalvedCount + 1, Adj, CoinsTuple, K, Memo1
                                       ),
            TotalPoints2 = PointsFromU + ChildrenPoints2,

            Result = max(TotalPoints1, TotalPoints2),
            UpdatedMemo = gb_trees:insert({U, HalvedCount}, Result, Memo2),
            {Result, UpdatedMemo}
    end.

collect_children_points(ChildrenList, U, Parent, ChildHalvedCount, Adj, CoinsTuple, K, CurrentMemo) ->
    lists:foldl(
        fun(V, {AccPoints, AccMemo}) ->
            case V /= Parent of
                true ->
                    {ChildResult, NewMemo} = dfs(V, U, ChildHalvedCount, Adj, CoinsTuple, K, AccMemo),
                    {AccPoints + ChildResult, NewMemo};
                false ->
                    {AccPoints, AccMemo}
            end
        end,
        {0, CurrentMemo},
        ChildrenList
    ).

max(A, B) when A >= B -> A;
max(A, B) -> B.