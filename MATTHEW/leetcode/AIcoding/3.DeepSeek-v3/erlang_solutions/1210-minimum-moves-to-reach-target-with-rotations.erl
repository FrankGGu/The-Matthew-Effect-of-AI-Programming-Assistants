-module(solution).
-export([minimum_moves/1]).

minimum_moves(Grid) ->
    N = length(Grid),
    Start = {{0, 0}, {0, 1}},
    Target = {{N - 1, N - 2}, {N - 1, N - 1}},
    Queue = queue:in({Start, 0}, queue:new()),
    Visited = sets:add_element(Start, sets:new()),
    bfs(Grid, Queue, Visited, Target).

bfs(Grid, Queue, Visited, Target) ->
    case queue:out(Queue) of
        {empty, _} -> -1;
        {{value, {Pos, Steps}}, Q} ->
            case Pos of
                Target -> Steps;
                _ ->
                    {NewQueue, NewVisited} = process_moves(Grid, Pos, Steps, Q, Visited),
                    bfs(Grid, NewQueue, NewVisited, Target)
            end
    end.

process_moves(Grid, {{X1, Y1}, {X2, Y2}} = Pos, Steps, Q, Visited) ->
    N = length(Grid),
    Moves = [],
    Moves1 = case can_move_right(Grid, Pos, N) of
                 true -> [{{X1, Y1 + 1}, {X2, Y2 + 1}} | Moves];
                 false -> Moves
             end,
    Moves2 = case can_move_down(Grid, Pos, N) of
                 true -> [{{X1 + 1, Y1}, {X2 + 1, Y2}} | Moves1];
                 false -> Moves1
             end,
    Moves3 = case can_rotate_clockwise(Grid, Pos, N) of
                 true -> [{{X1, Y1}, {X1 + 1, Y1}} | Moves2];
                 false -> Moves2
             end,
    Moves4 = case can_rotate_counter_clockwise(Grid, Pos, N) of
                 true -> [{{X1, Y1}, {X1, Y1 + 1}} | Moves3];
                 false -> Moves3
             end,
    lists:foldl(fun(NewPos, {QueueAcc, VisitedAcc}) ->
                    case sets:is_element(NewPos, VisitedAcc) of
                        true -> {QueueAcc, VisitedAcc};
                        false ->
                            NewQueue = queue:in({NewPos, Steps + 1}, QueueAcc),
                            NewVisited = sets:add_element(NewPos, VisitedAcc),
                            {NewQueue, NewVisited}
                    end
                end, {Q, Visited}, Moves4).

can_move_right(Grid, {{X1, Y1}, {X2, Y2}}, N) ->
    Y2 + 1 < N andalso
    (X1 =:= X2) andalso
    (Y2 + 1 < N) andalso
    (lists:nth(X1 + 1, lists:nth(Y2 + 1 + 1, Grid)) =:= 0).

can_move_down(Grid, {{X1, Y1}, {X2, Y2}}, N) ->
    X2 + 1 < N andalso
    (Y1 =:= Y2) andalso
    (X2 + 1 < N) andalso
    (lists:nth(X2 + 1 + 1, lists:nth(Y1 + 1, Grid)) =:= 0).

can_rotate_clockwise(Grid, {{X1, Y1}, {X2, Y2}}, N) ->
    (X1 =:= X2) andalso
    (Y1 + 1 =:= Y2) andalso
    (X1 + 1 < N) andalso
    (lists:nth(X1 + 1 + 1, lists:nth(Y1 + 1, Grid)) =:= 0 andalso
    (lists:nth(X1 + 1 + 1, lists:nth(Y2 + 1, Grid)) =:= 0.

can_rotate_counter_clockwise(Grid, {{X1, Y1}, {X2, Y2}}, N) ->
    (Y1 =:= Y2) andalso
    (X1 + 1 =:= X2) andalso
    (Y1 + 1 < N) andalso
    (lists:nth(X1 + 1, lists:nth(Y1 + 1 + 1, Grid)) =:= 0) andalso
    (lists:nth(X2 + 1, lists:nth(Y1 + 1 + 1, Grid)) =:= 0).