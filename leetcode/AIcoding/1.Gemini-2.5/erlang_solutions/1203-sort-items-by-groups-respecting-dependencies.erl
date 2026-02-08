-module(solution).
-export([sortItems/5]).

topo_sort(N, NodesToConsider, AdjacencyList, IndegreeList) ->
    InitialQueue = lists:filter(fun(I) -> array:get(I, IndegreeList) == 0 end, NodesToConsider),
    topo_sort_bfs(InitialQueue, [], length(NodesToConsider), AdjacencyList, IndegreeList).

topo_sort_bfs([], Sorted, ExpectedCount, _AdjacencyList, _IndegreeList) when length(Sorted) == ExpectedCount ->
    {ok, lists:reverse(Sorted)};
topo_sort_bfs([], _Sorted, _ExpectedCount, _AdjacencyList, _IndegreeList) -> % Cycle detected or not all items processed
    {error, no_solution};
topo_sort_bfs([H|T], Sorted, ExpectedCount, AdjacencyList, IndegreeList) ->
    NewSorted = [H|Sorted],
    Neighbors = array:get(H, AdjacencyList),
    {NewIndegreeList, NewQueue} = lists:foldl(
        fun(Neighbor, {CurrentIndegreeList, CurrentQueue}) ->
            NewIndegree = array:get(Neighbor, CurrentIndegreeList) - 1,
            UpdatedIndegreeList = array:set(Neighbor, NewIndegree, CurrentIndegreeList),
            IfNewQueue = if NewIndegree == 0 -> [Neighbor|CurrentQueue]; true -> CurrentQueue end,
            {UpdatedIndegreeList, IfNewQueue}
        end,
        {IndegreeList, T},
        Neighbors
    ),
    topo_sort_bfs(NewQueue, NewSorted, ExpectedCount, AdjacencyList, NewIndegreeList).

sortItems(N, M, GroupList, BeforeItemsList) ->
    % Convert input lists to arrays for O(1) access
    GroupArray = array:from_list(GroupList),
    BeforeItemsArray = array:from_list(BeforeItemsList),

    % 1. Assign unique group IDs for items not in any group
    %    And initialize group_map (group_id -> list of items in group)
    %    And determine total number of groups (MaxGroupIdx + 1)
    InitialGroupMap = #{},
    InitialMaxGroupIdx = M - 1, % M is the count, so M-1 is max index for 0-indexed groups

    {FinalGroupMap, MaxGroupIdx, UpdatedGroupArray} = lists:foldl(
        fun(I, {AccGroupMap, AccMaxGroupIdx, AccGroupArray}) ->
            CurrentGroup = array:get(I, AccGroupArray),
            {NewGroup, NewMaxGroupIdx} = if CurrentGroup == -1 ->
                                            {AccMaxGroupIdx + 1, AccMaxGroupIdx + 1};
                                          true ->
                                            {CurrentGroup, AccMaxGroupIdx}
                                         end,
            UpdatedAccGroupMap = maps:update_with(NewGroup, fun(L) -> [I|L] end, [I], AccGroupMap),
            UpdatedAccGroupArray = array:set(I, NewGroup, AccGroupArray),
            {UpdatedAccGroupMap, NewMaxGroupIdx, UpdatedAccGroupArray}
        end,
        {InitialGroupMap, InitialMaxGroupIdx, GroupArray},
        lists:seq(0, N - 1)
    ),
    TotalGroups = MaxGroupIdx + 1,

    % 2. Initialize item_adj, item_indegree, group_adj, group_indegree
    ItemAdj = array:new(N, {default, []}),
    ItemIndegree = array:new(N, {default, 0}),
    GroupAdj = array:new(TotalGroups, {default, []}),
    GroupIndegree = array:new(TotalGroups, {default, 0}),

    % 3. Build item_adj, item_indegree, group_adj, group_indegree
    {FinalItemAdj, FinalItemIndegree, FinalGroupAdj, FinalGroupIndegree} = lists:foldl(
        fun(I, {AccItemAdj, AccItemIndegree, AccGroupAdj, AccGroupIndegree}) ->
            GroupI = array:get(I, UpdatedGroupArray),
            BeforeList = array:get(I, BeforeItemsArray),
            lists:foldl(
                fun(PrevItem, {InnerItemAdj, InnerItemIndegree, InnerGroupAdj, InnerGroupIndegree}) ->
                    % Item dependencies: PrevItem -> I
                    NewItemAdj = array:set(PrevItem, [I | array:get(PrevItem, InnerItemAdj)], InnerItemAdj),
                    NewItemIndegree = array:set(I, array:get(I, InnerItemIndegree) + 1, InnerItemIndegree),

                    % Group dependencies: GroupPrev -> GroupI if GroupPrev /= GroupI
                    GroupPrev = array:get(PrevItem, UpdatedGroupArray),
                    {UpdatedGroupAdj, UpdatedGroupIndegree} = if GroupI /= GroupPrev ->
                                                                    % Add dependency only once
                                                                    CurrentGroupAdjList = array:get(GroupPrev, InnerGroupAdj),
                                                                    if not lists:member(GroupI, CurrentGroupAdjList) -> % Check to avoid duplicate edges and double counting indegree
                                                                        NewGroupAdj = array:set(GroupPrev, [GroupI | CurrentGroupAdjList], InnerGroupAdj),
                                                                        NewGroupIndegree = array:set(GroupI, array:get(GroupI, InnerGroupIndegree) + 1, InnerGroupIndegree),
                                                                        {NewGroupAdj, NewGroupIndegree};
                                                                    true ->
                                                                        {InnerGroupAdj, InnerGroupIndegree}
                                                                    end;
                                                                true ->
                                                                    {InnerGroupAdj, InnerGroupIndegree}
                                                                end,
                    {NewItemAdj, NewItemIndegree, UpdatedGroupAdj, UpdatedGroupIndegree}
                end,
                {AccItemAdj, AccItemIndegree, AccGroupAdj, AccGroupIndegree},
                BeforeList
            )
        end,
        {ItemAdj, ItemIndegree, GroupAdj, GroupIndegree},
        lists:seq(0, N - 1)
    ),

    % 4. Topological Sort for Groups
    case topo_sort(TotalGroups, lists:seq(0, TotalGroups - 1), FinalGroupAdj, FinalGroupIndegree) of
        {ok, SortedGroups} ->
            % 5. Topological Sort for Items within each Group
            try
                SortedItemsInGroups = maps:fold(
                    fun(GId, ItemsInG, AccSortedItemsMap) ->
                        % Build internal adjacency list and indegree for items ONLY within this group
                        GroupInternalItemAdj = array:new(N, {default, []}), % Use N for global indices
                        GroupInternalItemIndegree = array:new(N, {default, 0}),

                        {FinalGroupInternalItemAdj, FinalGroupInternalItemIndegree} = lists:foldl(
                            fun(Item, {CurAdj, CurIndegree}) ->
                                BeforeListForCurrentItem = array:get(Item, BeforeItemsArray),
                                lists:foldl(
                                    fun(PrevItem, {InnerAdj, InnerIndegree}) ->
                                        IfSameGroup = if array:get(PrevItem, UpdatedGroupArray) == GId ->
                                                            NewInnerAdj = array:set(PrevItem, [Item | array:get(PrevItem, InnerAdj)], InnerAdj),
                                                            NewInnerIndegree = array:set(Item, array:get(Item, InnerIndegree) + 1, InnerIndegree),
                                                            {NewInnerAdj, NewInnerIndegree};
                                                      true ->
                                                            {InnerAdj, InnerIndegree}
                                                    end,
                                        IfSameGroup
                                    end,
                                    {CurAdj, CurIndegree},
                                    BeforeListForCurrentItem
                                )
                            end,
                            {GroupInternalItemAdj, GroupInternalItemIndegree},
                            ItemsInG
                        ),

                        case topo_sort(N, ItemsInG, FinalGroupInternalItemAdj, FinalGroupInternalItemIndegree) of
                            {ok, GroupSortedItems} ->
                                maps:put(GId, GroupSortedItems, AccSortedItemsMap);
                            {error, no_solution} ->
                                throw(no_solution) % Propagate error
                        end
                    end,
                    #{},
                    FinalGroupMap
                ),

                % 6. Combine results
                lists:foldl(
                    fun(GId, AccResult) ->
                        case maps:find(GId, SortedItemsInGroups) of
                            {ok, Items} -> AccResult ++ Items;
                            error -> throw(no_solution) % Should not happen if all groups were processed
                        end
                    end,
                    [],
                    SortedGroups
                )
            catch
                throw:no_solution -> []
            end;
        {error, no_solution} ->
            [] % Return empty list if group sort fails
    end.