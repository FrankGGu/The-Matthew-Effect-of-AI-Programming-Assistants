-module(solution).
-export([find_circle_num/1]).

dfs(CurrentCity, N, IsConnectedArray, VisitedSet) ->
    NewVisitedSet = gb_sets:add(CurrentCity, VisitedSet),

    CurrentCityRow = array:get(CurrentCity, IsConnectedArray),

    lists:foldl(fun(Neighbor, AccVisitedSet) ->
        IsConnectedVal = array:get(Neighbor, CurrentCityRow),
        IsNeighborVisited = gb_sets:is_element(Neighbor, AccVisitedSet),

        if IsConnectedVal == 1 andalso not IsNeighborVisited ->
            dfs(Neighbor, N, IsConnectedArray, AccVisitedSet);
        true ->
            AccVisitedSet
        end
    end, NewVisitedSet, lists:seq(0, N-1)).

find_circle_num(IsConnected) ->
    N = length(IsConnected),

    IsConnectedArray = array:from_list(lists:map(fun array:from_list/1, IsConnected)),

    InitialVisitedSet = gb_sets:new(),

    {NumProvinces, _FinalVisitedSet} = lists:foldl(fun(City, {AccProvinces, AccVisitedSet}) ->
        if not gb_sets:is_element(City, AccVisitedSet) ->
            NewProvinces = AccProvinces + 1,
            UpdatedVisitedSet = dfs(City, N, IsConnectedArray, AccVisitedSet),
            {NewProvinces, UpdatedVisitedSet};
        true ->
            {AccProvinces, AccVisitedSet}
        end
    end, {0, InitialVisitedSet}, lists:seq(0, N-1)),

    NumProvinces.