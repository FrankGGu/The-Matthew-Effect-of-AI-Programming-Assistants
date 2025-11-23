-module(solution).
-export([nearest_exit/2]).

nearest_exit(Maze, Entrance) ->
    {Rows, Cols} = {length(Maze), length(hd(Maze))},
    EntrancePos = {element(1, Entrance), element(2, Entrance)},
    bfs([{EntrancePos, 0}], Maze, EntrancePos, Rows, Cols).

bfs([], _, _, _, _) -> -1;
bfs([{Position, Steps} | Rest], Maze, EntrancePos, Rows, Cols) ->
    case Position == EntrancePos of
        true -> bfs(Rest, Maze, EntrancePos, Rows, Cols);
        false -> 
            case Position in [{X, Y} || X <- lists:seq(1, Rows), Y <- lists:seq(1, Cols), 
                                    is_exit({X, Y}, Rows, Cols), 
                                    Maze =:= 0] of
                true -> Steps;
                false -> 
                    NewPositions = get_neighbors(Position, Rows, Cols),
                    Next = lists:filter(fun(P) -> Maze =:= 0 end, NewPositions),
                    bfs(Rest ++ [{P, Steps + 1} || P <- Next], Maze, EntrancePos, Rows, Cols)
            end
    end.

get_neighbors({X, Y}, Rows, Cols) ->
    [{X-1, Y}, {X+1, Y}, {X, Y-1}, {X, Y+1}].

is_exit({X, Y}, Rows, Cols) ->
    (X =:= 1; X =:= Rows; Y =:= 1; Y =:= Cols).