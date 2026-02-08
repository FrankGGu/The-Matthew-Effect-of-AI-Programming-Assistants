-module(grid_teleportation_traversal).
-export([min_steps/2]).

min_steps(Grid, Teleports) ->
    Start = {0, 0},
    End = {length(Grid) - 1, length(Grid) - 1},
    bfs([{Start, 0}], End, Grid, Teleports, []).

bfs([], _, _, _, _) -> -1;
bfs([{Pos, Steps} | Rest], End, Grid, Teleports, Visited) ->
    case Pos of
        End -> Steps;
        _ ->
            NewVisited = [Pos | Visited],
            NextMoves = get_next_moves(Pos, Grid, Teleports, NewVisited),
            bfs(Rest ++ NextMoves, End, Grid, Teleports, NewVisited)
    end.

get_next_moves({X, Y}, Grid, Teleports, Visited) ->
    Moves = [{X + 1, Y}, {X - 1, Y}, {X, Y + 1}, {X, Y - 1}],
    ValidMoves = lists:filter(fun(Pos) -> is_valid(Pos, Grid, Visited) end, Moves),
    TeleportMoves = lists:filter(fun(Pos) -> is_valid(Pos, Grid, Visited) end, Teleports),
    ValidMoves ++ TeleportMoves.

is_valid({X, Y}, Grid, Visited) ->
    X >= 0, Y >= 0, X < length(Grid), Y < length(Grid) andalso
    not lists:member({X, Y}, Visited) andalso
    lists:nth(Y + 1, lists:nth(X + 1, Grid)) =:= 0.