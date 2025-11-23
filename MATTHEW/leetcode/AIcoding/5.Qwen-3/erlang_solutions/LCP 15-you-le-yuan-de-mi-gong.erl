-module(maze).
-export([maze/2]).

maze(Start, End) ->
    maze(Start, End, 0).

maze({X1, Y1}, {X2, Y2}, Steps) ->
    case {X1, Y1} of
        {X2, Y2} -> Steps;
        _ ->
            maze_next({X1, Y1}, {X2, Y2}, Steps)
    end.

maze_next({X, Y}, Target, Steps) ->
    Directions = [{X+1,Y}, {X-1,Y}, {X,Y+1}, {X,Y-1}],
    lists:foldl(fun(Dir, Acc) ->
        case Acc of
            {found, S} -> {found, S};
            _ ->
                case is_valid(Dir) of
                    true -> 
                        case maze(Dir, Target, Steps + 1) of
                            {found, S} -> {found, S};
                            _ -> Acc
                        end;
                    false -> Acc
                end
        end
    end, not_found, Directions).

is_valid({X, Y}) ->
    X >= 0 andalso Y >= 0 andalso X < 10 andalso Y < 10.