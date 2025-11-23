-module(min_days_disconnect_island).
-export([min_days_disconnect_island/1]).

min_days_disconnect_island(Grid) ->
    Rows = length(Grid),
    Cols = length(hd(Grid)),

    Is_Connected = fun(G) ->
        {R, C} = find_land(G),
        if R == -1 ->
            true;
        true ->
            Visited = sets:new(),
            {_, _, _} = dfs(G, R, C, sets:add({R, C}, Visited)),
            count_land(G) == sets:size(Visited)
        end
    end.

    find_land = fun(G) ->
        Rows1 = length(G),
        Cols1 = length(hd(G)),
        find_land_helper(G, Rows1, Cols1, 0, 0)
    end.

    find_land_helper = fun(G, Rows1, Cols1, R, C) ->
        if R >= Rows1 ->
            {-1, -1};
        true ->
            if C >= Cols1 ->
                find_land_helper(G, Rows1, Cols1, R + 1, 0);
            true ->
                case lists:nth(R + 1, G) of
                    Row ->
                        case lists:nth(C + 1, Row) of
                            1 -> {R, C};
                            _ -> find_land_helper(G, Rows1, Cols1, R, C + 1)
                        end
                end
            end
        end
    end.

    dfs = fun(G, R, C, Visited) ->
        Rows1 = length(G),
        Cols1 = length(hd(G)),
        dfs_helper(G, R, C, Rows1, Cols1, Visited)
    end.

    dfs_helper = fun(G, R, C, Rows1, Cols1, Visited) ->
        Dirs = [{0, 1}, {0, -1}, {1, 0}, {-1, 0}],
        lists:foldl(
            fun({Dr, Dc}, {R1, C1, Visited1}) ->
                Nr = R1 + Dr,
                Nc = C1 + Dc,
                if Nr >= 0 andalso Nr < Rows1 andalso Nc >= 0 andalso Nc < Cols1 andalso
                   (not sets:is_element({Nr, Nc}, Visited1)) ->
                    case lists:nth(Nr + 1, G) of
                        Row ->
                            case lists:nth(Nc + 1, Row) of
                                1 ->
                                    dfs_helper(G, Nr, Nc, Rows1, Cols1, sets:add({Nr, Nc}, Visited1));
                                _ -> {R1, C1, Visited1}
                            end
                    end;
                true -> {R1, C1, Visited1}
                end
            end,
            {R, C, Visited},
            Dirs
        )
    end.

    count_land = fun(G) ->
        Rows1 = length(G),
        Cols1 = length(hd(G)),
        count_land_helper(G, Rows1, Cols1, 0, 0, 0)
    end.

    count_land_helper = fun(G, Rows1, Cols1, R, C, Count) ->
        if R >= Rows1 ->
            Count;
        true ->
            if C >= Cols1 ->
                count_land_helper(G, Rows1, Cols1, R + 1, 0, Count);
            true ->
                case lists:nth(R + 1, G) of
                    Row ->
                        case lists:nth(C + 1, Row) of
                            1 -> count_land_helper(G, Rows1, Cols1, R, C + 1, Count + 1);
                            _ -> count_land_helper(G, Rows1, Cols1, R, C + 1, Count)
                        end
                end
            end
        end
    end.

    Num_Land = count_land(Grid),

    if Num_Land == 0 ->
        0;
    true ->
        if not Is_Connected(Grid) ->
            0;
        true ->
            Has_Bridge = fun() ->
                Has_Bridge_Helper(Grid, Rows, Cols)
            end.

            Has_Bridge_Helper = fun(G, Rows1, Cols1) ->
                lists:any(
                    fun(R) ->
                        lists:any(
                            fun(C) ->
                                case lists:nth(R + 1, G) of
                                    Row ->
                                        case lists:nth(C + 1, Row) of
                                            1 ->
                                                New_Grid = update_grid(G, R, C, 0),
                                                not Is_Connected(New_Grid);
                                            _ -> false
                                        end
                                end
                            end,
                            lists:seq(0, Cols1 - 1)
                        )
                    end,
                    lists:seq(0, Rows1 - 1)
                )
            end.

            update_grid = fun(G, R, C, Value) ->
                lists:map(
                    fun(RowIndex) ->
                        case RowIndex of
                            R ->
                                Row = lists:nth(RowIndex + 1, G),
                                lists:map(
                                    fun(ColIndex) ->
                                        case ColIndex of
                                            C -> Value;
                                            _ -> lists:nth(ColIndex + 1, Row)
                                        end
                                    end,
                                    lists:seq(0, Cols - 1)
                                );
                            _ -> lists:nth(RowIndex + 1, G)
                        end
                    end,
                    lists:seq(0, Rows - 1)
                )
            end.

            if Has_Bridge() ->
                1;
            true ->
                2
            end
        end
    end.