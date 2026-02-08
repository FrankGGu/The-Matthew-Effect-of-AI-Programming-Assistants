-module(cat_mouse).
-export([canMouseWin/5]).

-spec canMouseWin(Grid :: [unicode:unicode_binary()], CatJump :: integer(), MouseJump :: integer()) -> boolean().
canMouseWin(Grid, CatJump, MouseJump) ->
    {Mx, My} = find_pos(Grid, $M),
    {Cx, Cy} = find_pos(Grid, $C),
    {Fx, Fy} = find_pos(Grid, $F),
    Rows = length(Grid),
    Cols = byte_size(hd(Grid)),
    Mem = maps:new(),
    case dfs(Mx, My, Cx, Cy, Fx, Fy, Rows, Cols, CatJump, MouseJump, Grid, 0, Mem) of
        {true, _} -> true;
        _ -> false
    end.

find_pos(Grid, Char) ->
    find_pos(Grid, Char, 0).

find_pos([Row | Rest], Char, X) ->
    case binary:match(Row, <<Char>>) of
        {Y, 1} -> {X, Y};
        nomatch -> find_pos(Rest, Char, X + 1)
    end.

dfs(Mx, My, Cx, Cy, Fx, Fy, Rows, Cols, CatJump, MouseJump, Grid, Turn, Mem) ->
    Key = {Mx, My, Cx, Cy, Turn rem 2},
    case maps:get(Key, Mem, undefined) of
        undefined ->
            Result = case Turn rem 2 of
                0 -> mouse_turn(Mx, My, Cx, Cy, Fx, Fy, Rows, Cols, CatJump, MouseJump, Grid, Turn, Mem);
                1 -> cat_turn(Mx, My, Cx, Cy, Fx, Fy, Rows, Cols, CatJump, MouseJump, Grid, Turn, Mem)
            end,
            {Res, NewMem} = Result,
            {Res, maps:put(Key, Res, NewMem)};
        Res -> {Res, Mem}
    end.

mouse_turn(Mx, My, Cx, Cy, Fx, Fy, Rows, Cols, CatJump, MouseJump, Grid, Turn, Mem) ->
    if
        Mx =:= Fx andalso My =:= Fy -> {true, Mem};
        Turn >= 1000 -> {false, Mem};
        true ->
            Directions = [{-1, 0}, {1, 0}, {0, -1}, {0, 1}],
            mouse_move(Mx, My, Cx, Cy, Fx, Fy, Rows, Cols, CatJump, MouseJump, Grid, Turn, Mem, Directions, MouseJump, false)
    end.

mouse_move(_, _, _, _, _, _, _, _, _, _, _, _, Mem, _, 0, Found) ->
    {Found, Mem};
mouse_move(Mx, My, Cx, Cy, Fx, Fy, Rows, Cols, CatJump, MouseJump, Grid, Turn, Mem, Directions, JumpLeft, Found) ->
    lists:foldl(fun({Dx, Dy}, {CurFound, CurMem}) ->
        case CurFound of
            true -> {true, CurMem};
            false ->
                Nx = Mx + Dx,
                Ny = My + Dy,
                if
                    Nx >= 0 andalso Nx < Rows andalso Ny >= 0 andalso Ny < Cols ->
                        case is_valid(Nx, Ny, Grid) of
                            true ->
                                case dfs(Nx, Ny, Cx, Cy, Fx, Fy, Rows, Cols, CatJump, MouseJump, Grid, Turn + 1, CurMem) of
                                    {true, NewMem} -> {true, NewMem};
                                    {false, NewMem} -> mouse_move(Nx, Ny, Cx, Cy, Fx, Fy, Rows, Cols, CatJump, MouseJump, Grid, Turn, NewMem, Directions, JumpLeft - 1, false)
                                end;
                            false -> {CurFound, CurMem}
                        end;
                    true -> {CurFound, CurMem}
                end
        end
    end, {Found, Mem}, Directions).

cat_turn(Mx, My, Cx, Cy, Fx, Fy, Rows, Cols, CatJump, MouseJump, Grid, Turn, Mem) ->
    if
        Mx =:= Cx andalso My =:= Cy -> {false, Mem};
        Mx =:= Fx andalso My =:= Fy -> {true, Mem};
        Turn >= 1000 -> {false, Mem};
        true ->
            Directions = [{-1, 0}, {1, 0}, {0, -1}, {0, 1}],
            cat_move(Mx, My, Cx, Cy, Fx, Fy, Rows, Cols, CatJump, MouseJump, Grid, Turn, Mem, Directions, CatJump, true)
    end.

cat_move(_, _, _, _, _, _, _, _, _, _, _, _, Mem, _, 0, Found) ->
    {Found, Mem};
cat_move(Mx, My, Cx, Cy, Fx, Fy, Rows, Cols, CatJump, MouseJump, Grid, Turn, Mem, Directions, JumpLeft, Found) ->
    lists:foldl(fun({Dx, Dy}, {CurFound, CurMem}) ->
        case CurFound of
            false -> {false, CurMem};
            true ->
                Nx = Cx + Dx,
                Ny = Cy + Dy,
                if
                    Nx >= 0 andalso Nx < Rows andalso Ny >= 0 andalso Ny < Cols ->
                        case is_valid(Nx, Ny, Grid) of
                            true ->
                                case dfs(Mx, My, Nx, Ny, Fx, Fy, Rows, Cols, CatJump, MouseJump, Grid, Turn + 1, CurMem) of
                                    {false, NewMem} -> {false, NewMem};
                                    {true, NewMem} -> cat_move(Mx, My, Nx, Ny, Fx, Fy, Rows, Cols, CatJump, MouseJump, Grid, Turn, NewMem, Directions, JumpLeft - 1, true)
                                end;
                            false -> {CurFound, CurMem}
                        end;
                    true -> {CurFound, CurMem}
                end
        end
    end, {Found, Mem}, Directions).

is_valid(X, Y, Grid) ->
    Row = lists:nth(X + 1, Grid),
    case binary:at(Row, Y) of
        $# -> false;
        _ -> true
    end.