-module(solution).
-export([minimum_obstacles/1]).

minimum_obstacles(Grid) ->
    Rows = length(Grid),
    Cols = length(hd(Grid)),
    Start = {0, 0},
    End = {Rows - 1, Cols - 1},
    Directions = [{-1, 0}, {1, 0}, {0, -1}, {0, 1}],
    Heap = heap:new(),
    Heap1 = heap:insert({0, Start}, Heap),
    Visited = sets:new(),
    bfs(Heap1, Visited, Grid, Directions, End).

bfs(Heap, Visited, Grid, Directions, End) ->
    case heap:is_empty(Heap) of
        true -> -1;
        false ->
            {{Cost, {X, Y}}, Heap1} = heap:extract(Heap),
            case {X, Y} =:= End of
                true -> Cost;
                false ->
                    case sets:is_element({X, Y}, Visited) of
                        true -> bfs(Heap1, Visited, Grid, Directions, End);
                        false ->
                            Visited1 = sets:add_element({X, Y}, Visited),
                            NewHeap = lists:foldl(
                                fun({Dx, Dy}, Acc) ->
                                    NX = X + Dx,
                                    NY = Y + Dy,
                                    case is_valid(NX, NY, Grid) of
                                        true ->
                                            case sets:is_element({NX, NY}, Visited1) of
                                                false ->
                                                    NewCost = Cost + lists:nth(NY + 1, lists:nth(NX + 1, Grid)),
                                                    heap:insert({NewCost, {NX, NY}}, Acc);
                                                true -> Acc
                                            end;
                                        false -> Acc
                                    end
                                end,
                                Heap1,
                                Directions
                            ),
                            bfs(NewHeap, Visited1, Grid, Directions, End)
                    end
            end
    end.

is_valid(X, Y, Grid) ->
    Rows = length(Grid),
    Cols = length(hd(Grid)),
    X >= 0 andalso X < Rows andalso Y >= 0 andalso Y < Cols.