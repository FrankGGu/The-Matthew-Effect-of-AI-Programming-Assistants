-module(solution).
-export([is_possible/1]).

is_possible(Grid) ->
    Rows = length(Grid),
    Cols = length(hd(Grid)),
    Path = find_path(Grid, Rows, Cols),
    case Path of
        false -> true;
        _ ->
            Flip = flip_one(Grid, Rows, Cols),
            not Flip
    end.

find_path(Grid, Rows, Cols) ->
    Start = find_start(Grid, Rows, Cols),
    find_path(Grid, Rows, Cols, Start, []).

find_path(Grid, Rows, Cols, {R, C}, Visited) ->
    case is_valid(Grid, R, C, Visited) of
        true ->
            case is_end(Grid, R, C, Rows, Cols) of
                true -> [{R, C}];
                false ->
                    NewVisited = [{R, C} | Visited],
                    Directions = [{-1, 0}, {1, 0}, {0, -1}, {0, 1}],
                    lists:foldl(fun({DR, DC}, Acc) ->
                                        NextR = R + DR,
                                        NextC = C + DC,
                                        case Acc of
                                            false -> find_path(Grid, Rows, Cols, {NextR, NextC}, NewVisited);
                                            _ -> Acc
                                        end
                                end, false, Directions)
            end;
        false -> false
    end.

is_valid(Grid, R, C, Visited) ->
    R >= 0 andalso R < length(Grid) andalso C >= 0 andalso C < length(hd(Grid)) andalso lists:keymember({R, C}, 1, Visited) == false andalso element(R+1, Grid) == element(C+1, element(R+1, Grid)).

is_end(Grid, R, C, Rows, Cols) ->
    R == 0 orelse R == Rows-1 orelse C == 0 orelse C == Cols-1.

find_start(Grid, Rows, Cols) ->
    lists:foldl(fun(R, Acc) ->
                        if Acc /= false -> Acc;
                           true ->
                                lists:foldl(fun(C, Acc2) ->
                                                    if Acc2 /= false -> Acc2;
                                                       true ->
                                                            case element(R+1, Grid) == element(C+1, element(R+1, Grid)) of
                                                                true -> {R, C};
                                                                false -> Acc2
                                                            end
                                                        end
                                                end, false, lists:seq(0, Cols-1))
                    end, false, lists:seq(0, Rows-1)).

flip_one(Grid, Rows, Cols) ->
    lists:foldl(fun(R, Acc) ->
                        if Acc /= false -> Acc;
                           true ->
                                lists:foldl(fun(C, Acc2) ->
                                                    if Acc2 /= false -> Acc2;
                                                       true ->
                                                            case element(R+1, Grid) == element(C+1, element(R+1, Grid)) of
                                                                true ->
                                                                    NewGrid = flip_cell(Grid, R, C),
                                                                    Path = find_path(NewGrid, Rows, Cols),
                                                                    case Path of
                                                                        false -> true;
                                                                        _ -> Acc2
                                                                    end;
                                                                false -> Acc2
                                                            end
                                                        end
                                                end, false, lists:seq(0, Cols-1))
                    end, false, lists:seq(0, Rows-1)).

flip_cell(Grid, R, C) ->
    Row = element(R+1, Grid),
    NewRow = setelement(C+1, Row, 1 - element(C+1, Row)),
    setelement(R+1, Grid, NewRow).