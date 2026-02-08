-module(solution).
-export([isPrintable/1]).

isPrintable(TargetGrid) ->
    case TargetGrid of
        [] -> true;
        [[]|_] -> true;
        _ ->
            {BoundingBoxes, UniqueColors} = get_bounding_boxes(TargetGrid),
            {AdjMap, InDegreeMap} = build_graph(TargetGrid, BoundingBoxes, UniqueColors),
            topological_sort(AdjMap, InDegreeMap, UniqueColors)
    end.

get_bounding_boxes(Grid) ->
    N = length(Grid),
    M = length(hd(Grid)),
    BoundingBoxes0 = #{},
    UniqueColors0 = sets:new(),

    {BoundingBoxes, UniqueColors} = lists:foldl(
        fun(R_idx, {AccBB, AccUC}) ->
            Row = lists:nth(R_idx + 1, Grid),
            lists:foldl(
                fun(C_idx, {InnerAccBB, InnerAccUC}) ->
                    Color = lists:nth(C_idx + 1, Row),
                    NewUC = sets:add_element(Color, InnerAccUC),
                    case maps:find(Color, InnerAccBB) of
                        {ok, {MinR, MinC, MaxR, MaxC}} ->
                            NewBB = maps:put(Color, {min(MinR, R_idx), min(MinC, C_idx), max(MaxR, R_idx), max(MaxC, C_idx)}, InnerAccBB);
                        error ->
                            NewBB = maps:put(Color, {R_idx, C_idx, R_idx, C_idx}, InnerAccBB)
                    end,
                    {NewBB, NewUC}
                end,
                {AccBB, AccUC},
                lists:seq(0, M - 1)
            )
        end,
        {BoundingBoxes0, UniqueColors0},
        lists:seq(0, N - 1)
    ),
    {BoundingBoxes, UniqueColors}.

build_graph(Grid, BoundingBoxes, UniqueColors) ->
    DependenciesMap0 = maps:from_list([{C, sets:new()} || C <- sets:to_list(UniqueColors)]),

    DependenciesMap = lists:foldl(
        fun(Color, AccDependencies) ->
            {MinR, MinC, MaxR, MaxC} = maps:get(Color, BoundingBoxes),
            CurrentDependencies = sets:new(),
            NewDependencies = lists:foldl(
                fun(R, RowAccDeps) ->
                    Row = lists:nth(R + 1, Grid),
                    lists:foldl(
                        fun(C, CellAccDeps) ->
                            CellColor = lists:nth(C + 1, Row),
                            if CellColor =/= Color ->
                                sets:add_element(CellColor, CellAccDeps);
                            true ->
                                CellAccDeps
                            end
                        end,
                        RowAccDeps,
                        lists:seq(MinC, MaxC)
                    )
                end,
                CurrentDependencies,
                lists:seq(MinR, MaxR)
            ),
            maps:put(Color, NewDependencies, AccDependencies)
        end,
        DependenciesMap0,
        sets:to_list(UniqueColors)
    ),

    AdjMap0 = maps:from_list([{C, sets:new()} || C <- sets:to_list(UniqueColors)]),
    InDegreeMap0 = maps:from_list([{C, 0} || C <- sets:to_list(UniqueColors)]),

    {FinalAdjMap, FinalInDegreeMap} = maps:fold(
        fun(Color, DepsSet, {AccAdj, AccInDegree}) ->
            lists:foldl(
                fun(DepColor, {InnerAccAdj, InnerAccInDegree}) ->
                    NewAdj = maps:update_with(DepColor, fun(S) -> sets:add_element(Color, S) end, sets:new(), InnerAccAdj),
                    NewInDegree = maps:update_with(Color, fun(V) -> V + 1 end, 0, InnerAccInDegree),
                    {NewAdj, NewInDegree}
                end,
                {AccAdj, AccInDegree},
                sets:to_list(DepsSet)
            )
        end,
        {AdjMap0, InDegreeMap0},
        DependenciesMap
    ),
    {FinalAdjMap, FinalInDegreeMap}.

topological_sort(AdjMap, InDegreeMap, UniqueColors) ->
    Queue0 = queue:new(),
    InitialPrintedCount = 0,

    {Queue, InitialPrintedCountCorrected} = maps:fold(
        fun(Color, Degree, {AccQ, AccCount}) ->
            if Degree == 0 ->
                {queue:in(Color, AccQ), AccCount + 1};
            true ->
                {AccQ, AccCount}
            end
        end,
        {Queue0, InitialPrintedCount},
        InDegreeMap
    ),

    NumColors = sets:size(UniqueColors),

    topological_sort_loop(Queue, InDegreeMap, AdjMap, InitialPrintedCountCorrected, NumColors).

topological_sort_loop(Queue, InDegreeMap, AdjMap, PrintedCount, NumColors) ->
    if PrintedCount == NumColors ->
        true;
    true ->
        case queue:out(Queue) of
            {{value, U}, NewQueue} ->
                Neighbors = maps:get(U, AdjMap, sets:new()),
                {NextInDegreeMap, NextQueue, NextPrintedCount} = lists:foldl(
                    fun(V, {AccInDegreeMap, AccQueue, AccPrintedCount}) ->
                        UpdatedDegree = maps:get(V, AccInDegreeMap) - 1,
                        NewAccInDegreeMap = maps:put(V, UpdatedDegree, AccInDegreeMap),
                        if UpdatedDegree == 0 ->
                            {NewAccInDegreeMap, queue:in(V, AccQueue), AccPrintedCount + 1};
                        true ->
                            {NewAccInDegreeMap, AccQueue, AccPrintedCount}
                        end
                    end,
                    {InDegreeMap, NewQueue, PrintedCount},
                    sets:to_list(Neighbors)
                ),
                topological_sort_loop(NextQueue, NextInDegreeMap, AdjMap, NextPrintedCount, NumColors);
            {empty, _} ->
                false
        end
    end.