-module(solution).
-export([gameOfLife/1]).

gameOfLife(Board) ->
    Rows = length(Board),
    Cols = case Rows of
                0 -> 0;
                _ -> length(hd(Board))
            end,
    NewBoard = lists:map(fun(Row) -> 
                            lists:map(fun(_) -> 0 end, Row)
                         end, Board),
    lists:foldl(fun(I, _) ->
                    lists:foldl(fun(J, _) ->
                                    LiveNeighbors = countLiveNeighbors(Board, I, J, Rows, Cols),
                                    Current = lists:nth(J+1, lists:nth(I+1, Board)),
                                    NewState = case Current of
                                                  1 when LiveNeighbors < 2 -> 0;
                                                  1 when LiveNeighbors > 3 -> 0;
                                                  1 -> 1;
                                                  0 when LiveNeighbors =:= 3 -> 1;
                                                  _ -> Current
                                               end,
                                    NewRow = lists:nth(I+1, NewBoard),
                                    UpdatedRow = setnth(J+1, NewRow, NewState),
                                    NewBoard2 = setnth(I+1, NewBoard, UpdatedRow),
                                    NewBoard2
                                end, NewBoard, lists:seq(0, Cols-1))
                end, NewBoard, lists:seq(0, Rows-1)).

countLiveNeighbors(Board, I, J, Rows, Cols) ->
    Directions = [{-1,-1}, {-1,0}, {-1,1},
                  {0,-1},          {0,1},
                  {1,-1},  {1,0},  {1,1}],
    lists:foldl(fun({Di, Dj}, Acc) ->
                    Ni = I + Di,
                    Nj = J + Dj,
                    if
                        Ni >= 0, Ni < Rows, Nj >= 0, Nj < Cols ->
                            Acc + lists:nth(Nj+1, lists:nth(Ni+1, Board));
                        true -> Acc
                    end
                end, 0, Directions).

setnth(1, [_|T], X) -> [X|T];
setnth(N, [H|T], X) -> [H|setnth(N-1, T, X)].