-module(solution).
-export([game_of_life/1]).

game_of_life(Board) ->
    M = length(Board),
    case M of
        0 -> [];
        _ ->
            N = length(hd(Board)),
            lists:map(fun(I) ->
                lists:map(fun(J) ->
                    LiveNeighbors = count_live_neighbors(Board, I, J, M, N),
                    Cell = lists:nth(J + 1, lists:nth(I + 1, Board)),
                    case Cell of
                        1 when LiveNeighbors < 2 -> 0;
                        1 when LiveNeighbors > 3 -> 0;
                        1 -> 1;
                        0 when LiveNeighbors =:= 3 -> 1;
                        0 -> 0
                    end
                end, lists:seq(0, N - 1))
            end, lists:seq(0, M - 1))
    end.

count_live_neighbors(Board, I, J, M, N) ->
    Directions = [{-1,-1}, {-1,0}, {-1,1}, {0,-1}, {0,1}, {1,-1}, {1,0}, {1,1}],
    lists:foldl(fun({Di, Dj}, Acc) ->
        NewI = I + Di,
        NewJ = J + Dj,
        if
            NewI >= 0, NewI < M, NewJ >= 0, NewJ < N ->
                case lists:nth(NewJ + 1, lists:nth(NewI + 1, Board)) of
                    1 -> Acc + 1;
                    _ -> Acc
                end;
            true -> Acc
        end
    end, 0, Directions).