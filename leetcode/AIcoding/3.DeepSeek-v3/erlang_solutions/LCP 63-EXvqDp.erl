-spec can_marble_game_win(board :: [unicode:unicode_binary()]) -> boolean().
can_marble_game_win(Board) ->
    Rows = length(Board),
    Cols = byte_size(hd(Board)),
    Grid = [binary_to_list(Row) || Row <- Board],
    Start = find_start(Grid, Rows, Cols),
    case Start of
        {X, Y} ->
            dfs(Grid, Rows, Cols, X, Y, sets:new());
        _ ->
            false
    end.

find_start(Grid, Rows, Cols) ->
    find_start(Grid, Rows, Cols, 0).

find_start(_, Rows, _, Row) when Row >= Rows -> none;
find_start(Grid, Rows, Cols, Row) ->
    case find_in_row(lists:nth(Row + 1, Grid), Cols, 0) of
        none -> find_start(Grid, Rows, Cols, Row + 1);
        Col -> {Row, Col}
    end.

find_in_row(_, Cols, Col) when Col >= Cols -> none;
find_in_row([H | T], Cols, Col) ->
    case H of
        $O -> Col;
        _ -> find_in_row(T, Cols, Col + 1)
    end.

dfs(Grid, Rows, Cols, X, Y, Visited) ->
    case is_goal(Grid, X, Y) of
        true -> true;
        false ->
            case sets:is_element({X, Y}, Visited) of
                true -> false;
                false ->
                    NewVisited = sets:add_element({X, Y}, Visited),
                    lists:any(fun({Dx, Dy}) ->
                        Nx = X + Dx,
                        Ny = Y + Dy,
                        case is_valid(Nx, Ny, Rows, Cols) andalso is_empty(Grid, Nx, Ny) of
                            true -> dfs(Grid, Rows, Cols, Nx, Ny, NewVisited);
                            false -> false
                        end
                    end, [{0,1}, {1,0}, {0,-1}, {-1,0}])
            end
    end.

is_goal(Grid, X, Y) ->
    lists:nth(Y + 1, lists:nth(X + 1, Grid)) =:= $T.

is_valid(X, Y, Rows, Cols) ->
    X >= 0 andalso X < Rows andalso Y >= 0 andalso Y < Cols.

is_empty(Grid, X, Y) ->
    lists:nth(Y + 1, lists:nth(X + 1, Grid)) =/= $#.