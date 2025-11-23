-module(solution).
-export([min_hamming_distance/3]).

find(I, ParentMap) ->
    case maps:find(I, ParentMap) of
        {ok, P} when P == I -> {I, ParentMap};
        {ok, P} ->
            {Root, NewParentMap} = find(P, ParentMap),
            {Root, maps:put(I, Root, NewParentMap)};
        error ->
            {I, maps:put(I, I, ParentMap)}
    end.

union(I, J, ParentMap) ->
    {RootI, ParentMap1} = find(I, ParentMap),
    {RootJ, ParentMap2} = find(J, ParentMap1),
    if RootI /= RootJ ->
        maps:put(RootI, RootJ, ParentMap2);
    true ->
        ParentMap2
    end.

min_hamming_distance(Source, Target, AllowedSwaps) ->
    N = length(Source),

    %% Convert Source and Target to arrays for O(1) access
    SourceArray = array:from_list(Source),
    TargetArray = array:from_list(Target),

    %% Build DSU structure
    InitialParentMap = maps:new(),
    FinalParentMap = lists:foldl(
        fun([I, J], AccParentMap) ->
            union(I, J, AccParentMap)
        end,
        InitialParentMap,
        AllowedSwaps
    ),

    %% Group source and target values by their component root
    %% Components = #{Root => #{source_counts => #{Val => Count}, target_counts => #{Val => Count}}}
    GroupedComponents = lists:foldl(
        fun(Idx, AccComponents) ->
            {Root, _} = find(Idx, FinalParentMap), %% Find root for current index

            SourceVal = array:get(Idx, SourceArray), %% O(1) access
            TargetVal = array:get(Idx, TargetArray), %% O(1) access

            ComponentData = maps:get(Root, AccComponents, #{source_counts => maps:new(), target_counts => maps:new()}),

            CurrentSourceCounts = maps:get(source_counts, ComponentData),
            NewSourceCounts = maps:update_with(SourceVal, fun(C) -> C + 1 end, 1, CurrentSourceCounts),

            CurrentTargetCounts = maps:get(target_counts, ComponentData),
            NewTargetCounts = maps:update_with(TargetVal, fun(C) -> C + 1 end, 1, CurrentTargetCounts),

            maps:put(Root, maps:put(source_counts, NewSourceCounts, maps:put(target_counts, NewTargetCounts, ComponentData)), AccComponents)
        end,
        maps:new(),
        lists:seq(0, N - 1)
    ),

    %% Calculate total Hamming distance
    lists:foldl(
        fun(ComponentData, AccTotalHD) ->
            SourceCounts = maps:get(source_counts, ComponentData),
            TargetCounts = maps:get(target_counts, ComponentData),

            ComponentSize = lists:foldl(fun({_, C}, Acc) -> Acc + C end, 0, maps:to_list(SourceCounts)),

            IntersectionSize = maps:fold(
                fun(Val, Count, Acc) ->
                    TargetCount = maps:get(Val, TargetCounts, 0),
                    Acc + min(Count, TargetCount)
                end,
                0,
                SourceCounts
            ),

            AccTotalHD + (ComponentSize - IntersectionSize)
        end,
        0,
        maps:values(GroupedComponents)
    ).