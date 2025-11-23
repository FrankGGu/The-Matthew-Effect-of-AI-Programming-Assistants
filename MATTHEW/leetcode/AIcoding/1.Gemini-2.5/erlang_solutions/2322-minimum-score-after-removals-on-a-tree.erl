-module(solution).
-export([minimum_score_after_removals/3]).

build_adj(N, Edges) ->
    Adj = array:new({0, N-1}, []),
    lists:foldl(fun([U, V], Acc) ->
        Acc1 = array:set(U, [V | array:get(U, Acc)], Acc),
        array:set(V, [U | array:get(V, Acc)], Acc1)
    end, Adj, Edges).

dfs(U, P, Adj, Vals, SubtreeXORs, ParentArray, StartTimeArray, EndTimeArray, Time) ->
    NewTime1 = Time + 1,
    StartTimeArray1 = array:set(U, NewTime1, StartTimeArray),
    ParentArray1 = array:set(U, P, ParentArray),
    CurrentXOR = array:get(U, Vals),

    {FinalXORSum, FinalSubtreeXORs, FinalParentArray, FinalStartTimeArray, FinalEndTimeArray, FinalTime} =
        lists:foldl(fun(V, {AccXOR, AccSubtreeXORs, AccParentArray, AccStartTimeArray, AccEndTimeArray, AccTime}) ->
            if V == P ->
                {AccXOR, AccSubtreeXORs, AccParentArray, AccStartTimeArray, AccEndTimeArray, AccTime};
            true ->
                {ChildXOR, ResSubtreeXORs, ResParentArray, ResStartTimeArray, ResEndTimeArray, ResTime} =
                    dfs(V, U, Adj, Vals, AccSubtreeXORs, AccParentArray, AccStartTimeArray, AccEndTimeArray, AccTime),
                {AccXOR bxor ChildXOR, ResSubtreeXORs, ResParentArray, ResStartTimeArray, ResEndTimeArray, ResTime}
            end
        end, {CurrentXOR, SubtreeXORs, ParentArray1, StartTimeArray1, EndTimeArray, NewTime1}, array:get(U, Adj)),

    SubtreeXORs1 = array:set(U, FinalXORSum, FinalSubtreeXORs),
    NewTime2 = FinalTime + 1,
    EndTimeArray1 = array:set(U, NewTime2, FinalEndTimeArray),
    {FinalXORSum, SubtreeXORs1, FinalParentArray, FinalStartTimeArray, EndTimeArray1, NewTime2}.

is_ancestor(U, V, StartTimeArray, EndTimeArray) ->
    StartTimeU = array:get(U, StartTimeArray),
    EndTimeU = array:get(U, EndTimeArray),
    StartTimeV = array:get(V, StartTimeArray),
    EndTimeV = array:get(V, EndTimeArray),
    StartTimeU =< StartTimeV andalso EndTimeU >= EndTimeV.

calculate_min_score(N, Edges, TotalXOR, SubtreeXORs, StartTimeArray, EndTimeArray) ->
    MinScore = 1 bsl 30, % A sufficiently large initial value for minimum score

    lists:foldl(fun(Edge1, AccMinScore1) ->
        [U1, V1] = Edge1,
        %% Ensure V1 is the child (deeper node) for consistent logic when cutting edge (U1, V1)
        {RootU1, RootV1} =
            if array:get(U1, StartTimeArray) < array:get(V1, StartTimeArray) -> {U1, V1};
            true -> {V1, U1}
            end,

        lists:foldl(fun(Edge2, AccMinScore2) ->
            [U2, V2] = Edge2,
            %% Skip if Edge1 is the same as Edge2
            if (U1 == U2 andalso V1 == V2) orelse (U1 == V2 andalso V1 == U2) ->
                AccMinScore2;
            true ->
                %% Ensure V2 is the child (deeper node) for consistent logic when cutting edge (U2, V2)
                {RootU2, RootV2} =
                    if array:get(U2, StartTimeArray) < array:get(V2, StartTimeArray) -> {U2, V2};
                    true -> {V2, U2}
                    end,

                XOR_V1_Subtree = array:get(RootV1, SubtreeXORs),
                XOR_V2_Subtree = array:get(RootV2, SubtreeXORs),

                Scores =
                    if is_ancestor(RootV1, RootV2, StartTimeArray, EndTimeArray) -> %% RootV1 is ancestor of RootV2
                        %% Component 1: subtree at RootV2 (XOR_V2_Subtree)
                        %% Component 2: subtree at RootV1 excluding subtree at RootV2 (XOR_V1_Subtree bxor XOR_V2_Subtree)
                        %% Component 3: rest of tree (TotalXOR bxor XOR_V1_Subtree)
                        [XOR_V2_Subtree, XOR_V1_Subtree bxor XOR_V2_Subtree, TotalXOR bxor XOR_V1_Subtree];
                    is_ancestor(RootV2, RootV1, StartTimeArray, EndTimeArray) -> %% RootV2 is ancestor of RootV1
                        %% Component 1: subtree at RootV1 (XOR_V1_Subtree)
                        %% Component 2: subtree at RootV2 excluding subtree at RootV1 (XOR_V2_Subtree bxor XOR_V1_Subtree)
                        %% Component 3: rest of tree (TotalXOR bxor XOR_V2_Subtree)
                        [XOR_V1_Subtree, XOR_V2_Subtree bxor XOR_V1_Subtree, TotalXOR bxor XOR_V2_Subtree];
                    true -> %% RootV1 and RootV2 are in different subtrees (neither is an ancestor of the other)
                        %% Component 1: subtree at RootV1 (XOR_V1_Subtree)
                        %% Component 2: subtree at RootV2 (XOR_V2_Subtree)
                        %% Component 3: rest of tree (TotalXOR bxor XOR_V1_Subtree bxor XOR_V2_Subtree)
                        [XOR_V1_Subtree, XOR_V2_Subtree, TotalXOR bxor XOR_V1_Subtree bxor XOR_V2_Subtree]
                    end,

                MaxVal = lists:max(Scores),
                MinVal = lists:min(Scores),
                CurrentScore = MaxVal - MinVal,
                min(AccMinScore2, CurrentScore)
            end
        end, AccMinScore1, Edges)
    end, MinScore, Edges).

minimum_score_after_removals(N, Edges, ValsList) ->
    Adj = build_adj(N, Edges),
    ValsArray = array:from_list(ValsList), % 0-indexed values

    SubtreeXORs = array:new({0, N-1}),
    Parent = array:new({0, N-1}, -1), % Parent array, -1 for root
    StartTime = array:new({0, N-1}),
    EndTime = array:new({0, N-1}),

    %% Perform DFS starting from node 0 (arbitrary root)
    {_RootXORSum, FinalSubtreeXORs, _FinalParent, FinalStartTime, FinalEndTime, _FinalTime} =
        dfs(0, -1, Adj, ValsArray, SubtreeXORs, Parent, StartTime, EndTime, 0),

    TotalXOR = array:get(0, FinalSubtreeXORs), % XOR sum of the entire tree

    calculate_min_score(N, Edges, TotalXOR, FinalSubtreeXORs, FinalStartTime, FinalEndTime).