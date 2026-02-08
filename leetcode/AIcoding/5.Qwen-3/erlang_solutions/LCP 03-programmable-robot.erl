-module(robot).
-export([move/4]).

move(Rows, Cols, Obstacles, Instructions) ->
    {X, Y} = {0, 0},
    Dir = 0,
    move_helper(X, Y, Dir, Instructions, Rows, Cols, Obstacles).

move_helper(X, Y, Dir, [], _Rows, _Cols, _Obstacles) ->
    {X, Y};

move_helper(X, Y, Dir, [H | T], Rows, Cols, Obstacles) ->
    case H of
        'U' ->
            NewX = X - 1,
            NewY = Y,
            if
                NewX >= 0 andalso not is_obstacle(NewX, NewY, Obstacles) ->
                    move_helper(NewX, NewY, Dir, T, Rows, Cols, Obstacles);
                true ->
                    move_helper(X, Y, Dir, T, Rows, Cols, Obstacles)
            end;
        'D' ->
            NewX = X + 1,
            NewY = Y,
            if
                NewX < Rows andalso not is_obstacle(NewX, NewY, Obstacles) ->
                    move_helper(NewX, NewY, Dir, T, Rows, Cols, Obstacles);
                true ->
                    move_helper(X, Y, Dir, T, Rows, Cols, Obstacles)
            end;
        'L' ->
            NewX = X,
            NewY = Y - 1,
            if
                NewY >= 0 andalso not is_obstacle(NewX, NewY, Obstacles) ->
                    move_helper(NewX, NewY, Dir, T, Rows, Cols, Obstacles);
                true ->
                    move_helper(X, Y, Dir, T, Rows, Cols, Obstacles)
            end;
        'R' ->
            NewX = X,
            NewY = Y + 1,
            if
                NewY < Cols andalso not is_obstacle(NewX, NewY, Obstacles) ->
                    move_helper(NewX, NewY, Dir, T, Rows, Cols, Obstacles);
                true ->
                    move_helper(X, Y, Dir, T, Rows, Cols, Obstacles)
            end;
        'W' ->
            move_helper(X, Y, Dir, T, Rows, Cols, Obstacles);
        'A' ->
            NewDir = (Dir - 1 + 4) rem 4,
            move_helper(X, Y, NewDir, T, Rows, Cols, Obstacles);
        'S' ->
            move_helper(X, Y, Dir, T, Rows, Cols, Obstacles);
        'D' ->
            NewDir = (Dir + 1) rem 4,
            move_helper(X, Y, NewDir, T, Rows, Cols, Obstacles)
    end.

is_obstacle(X, Y, Obstacles) ->
    lists:member({X, Y}, Obstacles).