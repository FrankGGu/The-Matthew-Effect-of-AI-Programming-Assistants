-module(solution).
-export([min_operations/2]).

min_operations(Arr, K) ->
    N = length(Arr),

    InitialGroupsMap = init_groups_map(K, maps:new()),

    PopulatedGroupsMap = populate_groups_map(0, Arr, K, InitialGroupsMap),

    calculate_total_operations_map(maps:values(PopulatedGroupsMap), 0).

init_groups_map(K, AccMap) when K > 0 ->
    init_groups_map(K - 1, maps:put(K - 1, [], AccMap));
init_groups_map(_K, AccMap) ->
    AccMap.

populate_groups_map(Idx, Arr, K, CurrentGroupsMap) when Idx < length(Arr) ->
    Element = lists:nth(Idx + 1, Arr),
    GroupIndex = Idx rem K,

    CurrentGroup = maps:get(GroupIndex, CurrentGroupsMap),
    NewGroup = [Element | CurrentGroup],
    UpdatedGroupsMap = maps:put(GroupIndex, NewGroup, CurrentGroupsMap),

    populate_groups_map(Idx + 1, Arr, K, UpdatedGroupsMap);
populate_groups_map(_Idx, _Arr, _K, CurrentGroupsMap) ->
    CurrentGroupsMap.

calculate_total_operations_map([], TotalOps) ->
    TotalOps;
calculate_total_operations_map([Group | RestGroups], AccOps) ->
    GroupLen = length(Group),
    if GroupLen == 0 ->
        calculate_total_operations_map(RestGroups, AccOps);
    true ->
        SortedGroup = lists:sort(Group),
        Median = lists:nth(GroupLen div 2 + 1, SortedGroup),
        OpsForGroup = GroupLen - count_occurrences(Median, Group),
        calculate_total_operations_map(RestGroups, AccOps + OpsForGroup)
    end.

count_occurrences(Element, List) ->
    lists:foldl(fun(X, Count) -> if X == Element -> Count + 1; true -> Count end end, 0, List).