-module(programmable_robot).
-export([is_programmable_robot_path_possible/4]).

is_programmable_robot_path_possible(m, n, obstacle_coordinates, instructions) ->
    Obstacles = sets:from_list(obstacle_coordinates),
    is_path_possible(0, 0, m, n, Obstacles, instructions, []).

is_path_possible(X, Y, M, N, Obstacles, [], _) ->
    true;
is_path_possible(X, Y, M, N, Obstacles, [H|T], Visited) ->
    case lists:member({X, Y}, Visited) of
        true ->
            false;
        false ->
            NewVisited = [{X, Y} | Visited],
            case H of
                'U' ->
                    NewY = Y + 1,
                    case (NewY >= N orelse sets:is_element({X, NewY}, Obstacles)) of
                        true ->
                            false;
                        false ->
                            is_path_possible(X, NewY, M, N, Obstacles, T, NewVisited)
                    end;
                'D' ->
                    NewY = Y - 1,
                    case (NewY < 0 orelse sets:is_element({X, NewY}, Obstacles)) of
                        true ->
                            false;
                        false ->
                            is_path_possible(X, NewY, M, N, Obstacles, T, NewVisited)
                    end;
                'R' ->
                    NewX = X + 1,
                    case (NewX >= M orelse sets:is_element({NewX, Y}, Obstacles)) of
                        true ->
                            false;
                        false ->
                            is_path_possible(NewX, Y, M, N, Obstacles, T, NewVisited)
                    end;
                'L' ->
                    NewX = X - 1,
                    case (NewX < 0 orelse sets:is_element({NewX, Y}, Obstacles)) of
                        true ->
                            false;
                        false ->
                            is_path_possible(NewX, Y, M, N, Obstacles, T, NewVisited)
                    end
            end
    end.