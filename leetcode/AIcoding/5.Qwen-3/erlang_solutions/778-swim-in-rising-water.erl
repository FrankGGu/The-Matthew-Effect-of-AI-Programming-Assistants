-module(solve).
-export([swim_in_rising_water/1]).

swim_in_rising_water(Grid) ->
    N = length(Grid),
    Visited = array:new(N * N, {default, false}),
    Heap = erl_heap:new(),
    erl_heap:insert(Heap, {hd(hd(Grid)), 0, 0}),
    array:set(0, true, Visited),
    Directions = [{-1, 0}, {1, 0}, {0, -1}, {0, 1}],
    swim_in_rising_water(Grid, N, Visited, Heap, Directions).

swim_in_rising_water(_, _, Visited, Heap, _) when erl_heap:is_empty(Heap) ->
    array:get((N-1)*(N-1), Visited) andalso (array:get((N-1)*(N-1), Visited) == true).

swim_in_rising_water(Grid, N, Visited, Heap, Directions) ->
    {{Val, X, Y}, NewHeap} = erl_heap:extract_min(Heap),
    Index = X * N + Y,
    if
        X == N-1 andalso Y == N-1 -> true;
        true ->
            lists:foreach(fun({DX, DY}) ->
                                NX = X + DX,
                                NY = Y + DY,
                                if
                                    NX >= 0 andalso NX < N andalso NY >= 0 andalso NY < N ->
                                        NextIndex = NX * N + NY,
                                        if not array:get(NextIndex, Visited) ->
                                            NewVisited = array:set(NextIndex, true, Visited),
                                            NextVal = grid_val(Grid, NX, NY),
                                            NewHeap2 = erl_heap:insert(NewHeap, {max(Val, NextVal), NX, NY}),
                                            swim_in_rising_water(Grid, N, NewVisited, NewHeap2, Directions);
                                        true -> ok
                                        end;
                                    true -> ok
                                end
                            end, Directions),
            swim_in_rising_water(Grid, N, Visited, NewHeap, Directions)
    end.

grid_val(Grid, X, Y) ->
    lists:nth(Y+1, lists:nth(X+1, Grid)).