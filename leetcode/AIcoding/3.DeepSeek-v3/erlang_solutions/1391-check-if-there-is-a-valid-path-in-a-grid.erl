-module(solution).
-export([has_valid_path/1]).

has_valid_path(Grid) ->
    M = length(Grid),
    N = length(hd(Grid)),
    Visited = sets:new(),
    case dfs(0, 0, M, N, Grid, Visited) of
        true -> true;
        false -> false
    end.

dfs(I, J, M, N, Grid, Visited) ->
    if
        I =:= M - 1, J =:= N - 1 -> true;
        true ->
            case sets:is_element({I, J}, Visited) of
                true -> false;
                false ->
                    NewVisited = sets:add_element({I, J}, Visited),
                    Street = lists:nth(J + 1, lists:nth(I + 1, Grid)),
                    Neighbors = get_neighbors(I, J, M, N, Street),
                    lists:any(fun({Ni, Nj}) ->
                        case is_connected(I, J, Ni, Nj, Grid) of
                            true -> dfs(Ni, Nj, M, N, Grid, NewVisited);
                            false -> false
                        end
                    end, Neighbors)
            end
    end.

get_neighbors(I, J, M, N, Street) ->
    case Street of
        1 -> [{I, J - 1}, {I, J + 1}];
        2 -> [{I - 1, J}, {I + 1, J}];
        3 -> [{I, J - 1}, {I + 1, J}];
        4 -> [{I, J + 1}, {I + 1, J}];
        5 -> [{I, J - 1}, {I - 1, J}];
        6 -> [{I - 1, J}, {I, J + 1}];
        _ -> []
    end.

is_connected(I, J, Ni, Nj, Grid) ->
    if
        Ni < 0; Nj < 0; Ni >= length(Grid); Nj >= length(hd(Grid)) -> false;
        true ->
            Street1 = lists:nth(J + 1, lists:nth(I + 1, Grid)),
            Street2 = lists:nth(Nj + 1, lists:nth(Ni + 1, Grid)),
            case {Ni - I, Nj - J} of
                {0, -1} -> % left
                    (Street1 =:= 1 orelse Street1 =:= 3 orelse Street1 =:= 5) andalso
                    (Street2 =:= 1 orelse Street2 =:= 4 orelse Street2 =:= 6);
                {0, 1} -> % right
                    (Street1 =:= 1 orelse Street1 =:= 4 orelse Street1 =:= 6) andalso
                    (Street2 =:= 1 orelse Street2 =:= 3 orelse Street2 =:= 5);
                {-1, 0} -> % up
                    (Street1 =:= 2 orelse Street1 =:= 5 orelse Street1 =:= 6) andalso
                    (Street2 =:= 2 orelse Street2 =:= 3 orelse Street2 =:= 4);
                {1, 0} -> % down
                    (Street1 =:= 2 orelse Street1 =:= 3 orelse Street1 =:= 4) andalso
                    (Street2 =:= 2 orelse Street2 =:= 5 orelse Street2 =:= 6);
                _ -> false
            end
    end.