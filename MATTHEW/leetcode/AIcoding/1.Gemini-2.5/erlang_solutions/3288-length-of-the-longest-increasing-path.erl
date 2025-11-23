-module(solution).
-export([longest_increasing_path/1]).

longest_increasing_path(Grid) ->
    Rows = length(Grid),
    if
        Rows == 0 ->
            0;
        true ->
            Cols = length(hd(Grid)),
            ArrayGrid = list_to_array_grid(Grid, Rows),

            Table = ets:new(lip_memo, [set, public, {read_concurrency, true}, {write_concurrency, true}]),
            MaxPath = calculate_max_path(0, 0, Rows, Cols, ArrayGrid, Table, 0),
            ets:delete(Table),
            MaxPath
    end.

list_to_array_grid(GridList, Rows) ->
    RowArrays = lists:map(fun(RowList) -> array:from_list(RowList) end, GridList),
    array:from_list(RowArrays).

calculate_max_path(R, C, Rows, Cols, ArrayGrid, Table, CurrentMax) when R < Rows ->
    NewMax = calculate_max_path_col(R, C, Rows, Cols, ArrayGrid, Table, CurrentMax),
    calculate_max_path(R + 1, 0, Rows, Cols, ArrayGrid, Table, NewMax);
calculate_max_path(_R, _C, _Rows, _Cols, _ArrayGrid, _Table, CurrentMax) ->
    CurrentMax.

calculate_max_path_col(R, C, Rows, Cols, ArrayGrid, Table, CurrentMax) when C < Cols ->
    PathLength = dfs(R, C, Rows, Cols, ArrayGrid, Table),
    NewMax = erlang:max(CurrentMax, PathLength),
    calculate_max_path_col(R, C + 1, Rows, Cols, ArrayGrid, Table, NewMax);
calculate_max_path_col(_R, _C, _Rows, _Cols, _ArrayGrid, _Table, CurrentMax) ->
    CurrentMax.

dfs(R, C, Rows, Cols, ArrayGrid, Table) ->
    case ets:lookup(Table, {R, C}) of
        [{_, Length}] ->
            Length;
        [] ->
            CurrentValue = array:get(C, array:get(R, ArrayGrid)),
            CurrentMaxPath = 1,

            Directions = [{0, 1}, {0, -1}, {1, 0}, {-1, 0}],

            PathFromNeighbors = 
                lists:foldl(fun({DR, DC}, AccMax) ->
                                    NR = R + DR,
                                    NC = C + DC,

                                    if
                                        NR >= 0 andalso NR < Rows andalso NC >= 0 andalso NC < Cols ->
                                            NeighborValue = array:get(NC, array:get(NR, ArrayGrid)),
                                            if
                                                NeighborValue > CurrentValue ->
                                                    PathFromNeighbor = dfs(NR, NC, Rows, Cols, ArrayGrid, Table),
                                                    erlang:max(AccMax, 1 + PathFromNeighbor);
                                                true ->
                                                    AccMax
                                            end;
                                        true ->
                                            AccMax
                                    end
                            end, CurrentMaxPath, Directions),

            ets:insert(Table, {{R, C}, PathFromNeighbors}),
            PathFromNeighbors
    end.