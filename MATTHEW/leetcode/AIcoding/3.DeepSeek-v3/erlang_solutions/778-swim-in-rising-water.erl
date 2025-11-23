-module(solution).
-export([swim_in_water/1]).

swim_in_water(Grid) ->
    N = length(Grid),
    Start = {0, 0},
    End = {N - 1, N - 1},
    PriorityQueue = pqueue:new(),
    InitialPQ = pqueue:in({lists:nth(1, lists:nth(1, Grid)), Start}, PriorityQueue),
    Visited = sets:new(),
    swim(Grid, InitialPQ, Visited, N).

swim(Grid, PQ, Visited, N) ->
    {{Time, {X, Y}}, NewPQ} = pqueue:out(PQ),
    case {X, Y} of
        {N - 1, N - 1} -> Time;
        _ ->
            case sets:is_element({X, Y}, Visited) of
                true -> swim(Grid, NewPQ, Visited, N);
                false ->
                    NewVisited = sets:add_element({X, Y}, Visited),
                    Neighbors = [{X + 1, Y}, {X - 1, Y}, {X, Y + 1}, {X, Y - 1}],
                    UpdatedPQ = lists:foldl(fun({NX, NY}, AccPQ) ->
                        case (NX >= 0) and (NX < N) and (NY >= 0) and (NY < N) and (not sets:is_element({NX, NY}, NewVisited)) of
                            true ->
                                NewTime = max(Time, lists:nth(NY + 1, lists:nth(NX + 1, Grid))),
                                pqueue:in({NewTime, {NX, NY}}, AccPQ);
                            false -> AccPQ
                        end
                    end, NewPQ, Neighbors),
                    swim(Grid, UpdatedPQ, NewVisited, N)
            end
    end.