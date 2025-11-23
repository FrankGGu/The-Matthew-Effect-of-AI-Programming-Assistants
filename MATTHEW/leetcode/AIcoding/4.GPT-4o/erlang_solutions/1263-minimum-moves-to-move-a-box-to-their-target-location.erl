-module(solution).
-export([min_moves/3]).

min_moves(Box, Target, Obstacles) ->
    Start = {elem(Box, 0), elem(Box, 1)},
    Finish = {elem(Target, 0), elem(Target, 1)},
    ObstaclesSet = sets:from_list(Obstacles),
    bfs([{Start, 0}], Finish, ObstaclesSet, sets:new(), 0).

bfs([], _, _, _, _) -> -1;
bfs([{Pos, Moves} | Rest], Finish, Obstacles, Visited, Limit) ->
    case Pos == Finish of
        true -> Moves;
        false ->
            NextMoves = [move(Pos, Direction) || Direction <- [{1, 0}, {0, 1}, {-1, 0}, {0, -1}]],
            NewVisited = sets:add(Pos, Visited),
            NewRest = lists:foldl(fun (NextPos, Acc) -> 
                case is_valid(NextPos, Obstacles, NewVisited) of 
                    true -> [{NextPos, Moves + 1} | Acc]; 
                    false -> Acc 
                end 
            end, Rest, NextMoves),
            bfs(NewRest, Finish, Obstacles, NewVisited, Limit)
    end.

move({X, Y}, {DX, DY}) -> {X + DX, Y + DY}.

is_valid({X, Y}, Obstacles, Visited) ->
    X >= 0, Y >= 0, 
    not sets:is_element({X, Y}, Obstacles),
    not sets:is_element({X, Y}, Visited).