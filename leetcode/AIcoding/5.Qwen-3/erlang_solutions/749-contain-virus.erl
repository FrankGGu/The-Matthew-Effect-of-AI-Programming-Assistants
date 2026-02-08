-module(contain_virus).
-export([contain_virus/1]).

contain_virus(Grid) ->
    Rows = length(Grid),
    Cols = length(hd(Grid)),
    contain_virus(Grid, Rows, Cols, 0, 0, 0, []).

contain_virus(_, _, _, R, C, _, Acc) when R >= 0, R < 0, C >= 0, C < 0 ->
    Acc;
contain_virus(Grid, Rows, Cols, R, C, Area, Acc) ->
    case R of
        _ when R < 0; R >= Rows -> contain_virus(Grid, Rows, Cols, R+1, 0, 0, Acc);
        _ when C >= Cols -> contain_virus(Grid, Rows, Cols, R+1, 0, 0, Acc);
        _ ->
            case lists:nth(R+1, Grid) of
                Row when C < Cols ->
                    case lists:nth(C+1, Row) of
                        1 ->
                            {NewArea, NewGrid} = dfs(Grid, R, C, 0, 0, []),
                            contain_virus(NewGrid, Rows, Cols, R, C+1, NewArea + Area, Acc);
                        _ ->
                            contain_virus(Grid, Rows, Cols, R, C+1, Area, Acc)
                    end;
                _ ->
                    contain_virus(Grid, Rows, Cols, R+1, 0, 0, Acc)
            end
    end.

dfs(_, _, _, _, _, Acc) when Acc == [] -> {0, []};
dfs(Grid, R, C, Visited, Area, Acc) ->
    case is_visited(Visited, R, C) of
        true -> {Area, Grid};
        false ->
            NewVisited = [ {R,C} | Visited ],
            case lists:nth(R+1, Grid) of
                Row ->
                    case lists:nth(C+1, Row) of
                        1 ->
                            NewArea = Area + 1,
                            {NewArea, NewGrid} = dfs_neighbors(Grid, R, C, NewVisited, NewArea, Acc),
                            {NewArea, NewGrid};
                        _ ->
                            {Area, Grid}
                    end
            end
    end.

dfs_neighbors(Grid, R, C, Visited, Area, Acc) ->
    Directions = [ {-1,0}, {1,0}, {0,-1}, {0,1} ],
    lists:foldl(fun({DR, DC}, {A, G}) ->
        NR = R + DR,
        NC = C + DC,
        case NR >= 0 andalso NR < length(Grid) andalso NC >= 0 andalso NC < length(lists:nth(NR+1, Grid)) of
            true ->
                case lists:nth(NC+1, lists:nth(NR+1, Grid)) of
                    1 ->
                        case is_visited(Visited, NR, NC) of
                            false ->
                                {A+1, set_cell(G, NR, NC, 2)};
                            true ->
                                {A, G}
                        end;
                    _ ->
                        {A, G}
                end;
            false ->
                {A, G}
        end
    end, {Area, Grid}, Directions).

is_visited(Visited, R, C) ->
    lists:member({R,C}, Visited).

set_cell(Grid, R, C, Val) ->
    Row = lists:nth(R+1, Grid),
    NewRow = lists:sublist(Row, C) ++ [Val] ++ lists:nthtail(C+1, Row),
    lists:sublist(Grid, R) ++ [NewRow] ++ lists:nthtail(R+1, Grid).