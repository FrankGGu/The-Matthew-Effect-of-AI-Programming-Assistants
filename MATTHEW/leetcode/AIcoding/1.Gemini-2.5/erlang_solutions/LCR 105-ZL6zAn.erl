-module(solution).
-export([max_area_of_island/1]).

max_area_of_island(Grid) ->
    Rows = length(Grid),
    if
        Rows == 0 -> 0;
        true ->
            Cols = length(hd(Grid)), % Assumes non-empty grid and uniform row length
            {MaxArea, _Visited} = find_max_area(0, 0, Rows, Cols, Grid, 0, gb_set:new()),
            MaxArea
    end.

find_max_area(R, _C, Rows, _Cols, _Grid, CurrentMaxArea, Visited) when R >= Rows ->
    {CurrentMaxArea, Visited};
find_max_area(R, C, Rows, Cols, Grid, CurrentMaxArea, Visited) when C >= Cols ->
    find_max_area(R + 1, 0, Rows, Cols, Grid, CurrentMaxArea, Visited);
find_max_area(R, C, Rows, Cols, Grid, CurrentMaxArea, Visited) ->
    case gb_set:is_member({R, C}, Visited) of
        true ->
            find_max_area(R, C + 1, Rows, Cols, Grid, CurrentMaxArea, Visited);
        false ->
            case get_cell(R, C, Grid) of
                0 -> % Water
                    find_max_area(R, C + 1, Rows, Cols, Grid, CurrentMaxArea, Visited);
                1 -> % Land and not visited
                    {Area, NewVisited} = calculate_island_area(R, C, Rows, Cols, Grid, Visited),
                    NewMaxArea = max(CurrentMaxArea, Area),
                    find_max_area(R, C + 1, Rows, Cols, Grid, NewMaxArea, NewVisited)
            end
    end.

calculate_island_area(R, C, Rows, Cols, Grid, Visited) ->
    % 1. Out of bounds check
    if
        R < 0; R >= Rows; C < 0; C >= Cols ->
            {0, Visited};
        true ->
            % 2. Check if already visited
            case gb_set:is_member({R, C}, Visited) of
                true ->
                    {0, Visited};
                false ->
                    % 3. Check if water
                    case get_cell(R, C, Grid) of
                        0 -> % Water
                            {0, Visited};
                        1 -> % Land and not visited
                            NewVisited = gb_set:add({R, C}, Visited),
                            CurrentArea = 1,
                            Neighbors = [{R, C + 1}, {R, C - 1}, {R + 1, C}, {R - 1, C}],
                            lists:foldl(fun({NR, NC}, {AccArea, AccVisited}) ->
                                            {SubArea, UpdatedVisited} = calculate_island_area(NR, NC, Rows, Cols, Grid, AccVisited),
                                            {AccArea + SubArea, UpdatedVisited}
                                        end, {CurrentArea, NewVisited}, Neighbors)
                    end
            end
    end.

get_cell(R, C, Grid) ->
    lists:nth(C + 1, lists:nth(R + 1, Grid)).