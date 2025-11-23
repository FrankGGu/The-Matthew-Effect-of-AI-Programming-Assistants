-module(solution).
-export([findCircleNum/1]).

findCircleNum(IsConnectedList) ->
    N = length(IsConnectedList),
    IsConnectedTuple = list_to_tuple_of_tuples(IsConnectedList),
    Visited = sets:new(),
    {Provinces, _FinalVisited} = find_provinces_dfs(0, N, IsConnectedTuple, Visited, 0),
    Provinces.

list_to_tuple_of_tuples(ListOfLists) ->
    list_to_tuple([list_to_tuple(Row) || Row <- ListOfLists]).

find_provinces_dfs(CityIdx, N, IsConnected, Visited, CurrentProvinces) when CityIdx >= N ->
    {CurrentProvinces, Visited};
find_provinces_dfs(CityIdx, N, IsConnected, Visited, CurrentProvinces) ->
    case sets:is_element(CityIdx, Visited) of
        true ->
            find_provinces_dfs(CityIdx + 1, N, IsConnected, Visited, CurrentProvinces);
        false ->
            NewProvinces = CurrentProvinces + 1,
            NewVisited = dfs_visit(CityIdx, N, IsConnected, Visited),
            find_provinces_dfs(CityIdx + 1, N, IsConnected, NewVisited, NewProvinces)
    end.

dfs_visit(City, N, IsConnected, Visited) ->
    NewVisited = sets:add_element(City, Visited),
    CityRow = element(City + 1, IsConnected),
    dfs_explore_neighbors(City, 0, N, CityRow, IsConnected, NewVisited).

dfs_explore_neighbors(_CurrentCity, NeighborIdx, N, _CityRow, _IsConnected, Visited) when NeighborIdx >= N ->
    Visited;
dfs_explore_neighbors(CurrentCity, NeighborIdx, N, CityRow, IsConnected, Visited) ->
    case element(NeighborIdx + 1, CityRow) of
        1 ->
            case sets:is_element(NeighborIdx, Visited) of
                true ->
                    dfs_explore_neighbors(CurrentCity, NeighborIdx + 1, N, CityRow, IsConnected, Visited);
                false ->
                    UpdatedVisited = dfs_visit(NeighborIdx, N, IsConnected, Visited),
                    dfs_explore_neighbors(CurrentCity, NeighborIdx + 1, N, CityRow, IsConnected, UpdatedVisited)
            end;
        0 ->
            dfs_explore_neighbors(CurrentCity, NeighborIdx + 1, N, CityRow, IsConnected, Visited)
    end.