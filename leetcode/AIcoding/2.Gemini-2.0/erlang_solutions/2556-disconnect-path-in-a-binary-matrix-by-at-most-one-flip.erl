-module(disconnect_path).
-export([solve/1]).

solve(Grid) ->
    Rows = length(Grid),
    Cols = length(hd(Grid)),
    solve(Grid, Rows, Cols).

solve(Grid, Rows, Cols) ->
    case Rows * Cols =< 2 of
        true ->
            true;
        false ->
            case can_reach(Grid, Rows, Cols) of
                false ->
                    true;
                true ->
                    find_disconnect(Grid, Rows, Cols)
            end
    end.

can_reach(Grid, Rows, Cols) ->
    can_reach(Grid, Rows, Cols, 0, 0, [], []).

can_reach(Grid, Rows, Cols, R, C, Visited, Path) ->
    case R == Rows - 1 and C == Cols - 1 of
        true ->
            true;
        false ->
            case lists:member({R, C}, Visited) of
                true ->
                    false;
                false ->
                    case get_value(Grid, R, C) of
                        1 ->
                            NewVisited = [{R, C} | Visited],
                            case (R + 1 < Rows) andalso (get_value(Grid, R + 1, C) == 1) of
                                true ->
                                    case can_reach(Grid, Rows, Cols, R + 1, C, NewVisited, [{R, C} | Path]) of
                                        true ->
                                            true;
                                        false ->
                                            case (C + 1 < Cols) andalso (get_value(Grid, R, C + 1) == 1) of
                                                true ->
                                                    can_reach(Grid, Rows, Cols, R, C + 1, NewVisited, [{R, C} | Path]);
                                                false ->
                                                    false
                                            end
                                    end;
                                false ->
                                    case (C + 1 < Cols) andalso (get_value(Grid, R, C + 1) == 1) of
                                        true ->
                                            can_reach(Grid, Rows, Cols, R, C + 1, NewVisited, [{R, C} | Path]);
                                        false ->
                                            false
                                    end
                            end;
                        false ->
                            false
                    end
            end
    end.

find_disconnect(Grid, Rows, Cols) ->
    find_disconnect(Grid, Rows, Cols, 0, 0).

find_disconnect(Grid, Rows, Cols, R, C) ->
    case R >= Rows of
        true ->
            false;
        false ->
            case C >= Cols of
                true ->
                    find_disconnect(Grid, Rows, Cols, R + 1, 0);
                false ->
                    case get_value(Grid, R, C) of
                        1 ->
                            NewGrid = set_value(Grid, R, C, 0),
                            case can_reach(NewGrid, Rows, Cols) of
                                false ->
                                    true;
                                true ->
                                    find_disconnect(Grid, Rows, Cols, R, C + 1)
                            end;
                        false ->
                            find_disconnect(Grid, Rows, Cols, R, C + 1)
                    end
            end
    end.

get_value(Grid, R, C) ->
    lists:nth(C + 1, lists:nth(R + 1, Grid)).

set_value(Grid, R, C, Value) ->
    {ok, Row} = lists:nth(R + 1, Grid),
    NewRow = lists:replace(C + 1, Value, Row),
    lists:replace(R + 1, NewRow, Grid).