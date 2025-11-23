-module(minimum_moves).
-export([minimum_moves/3]).

minimum_moves(N, [[Rs, Cs], [Rt, Ct]], Forbidden) ->
    ForbiddenSet = sets:from_list(lists:map(fun([R, C]) -> {R, C} end, Forbidden)),
    minimum_moves_helper(N, {Rs, Cs, 0}, {Rt, Ct, 0}, ForbiddenSet).

minimum_moves_helper(N, {Rs, Cs, Dir}, {Rt, Ct, Dt}, ForbiddenSet) ->
    Queue = queue:new(),
    queue:in({Rs, Cs, Dir, 0}, Queue),
    Visited = sets:new(),
    minimum_moves_bfs(N, Queue, {Rt, Ct, Dt}, ForbiddenSet, Visited).

minimum_moves_bfs(N, Queue, {Rt, Ct, Dt}, ForbiddenSet, Visited) ->
    case queue:is_empty(Queue) of
        true -> -1;
        false ->
            { {Rs, Cs, Dir, Moves}, NewQueue } = queue:out(Queue),
            case {Rs, Cs, Dir} of
                {Rt, Ct, Dt} -> Moves;
                _ ->
                    case sets:is_element({Rs, Cs, Dir}, Visited) of
                        true ->
                            minimum_moves_bfs(N, NewQueue, {Rt, Ct, Dt}, ForbiddenSet, Visited);
                        false ->
                            NewVisited = sets:add_element({Rs, Cs, Dir}, Visited),
                            NextStates = get_next_states(N, Rs, Cs, Dir, ForbiddenSet),
                            QueueWithNext = lists:foldl(fun({Nr, Nc, Ndir}, AccQueue) ->
                                queue:in({Nr, Nc, Ndir, Moves + 1}, AccQueue)
                            end, NewQueue, NextStates),
                            minimum_moves_bfs(N, QueueWithNext, {Rt, Ct, Dt}, ForbiddenSet, NewVisited)
                    end
            end
    end.

get_next_states(N, R, C, Dir, ForbiddenSet) ->
    lists:filter(fun(NextState) -> is_valid_state(N, NextState, ForbiddenSet) end,
                 [ {R, C + 1, 0}, {R, C - 1, 0}, {R + 1, C, 1}, {R - 1, C, 1},
                   {R, C, (Dir + 1) rem 2}, {R, C, (Dir + 1) rem 2} ]).

is_valid_state(N, {R, C, 0}, ForbiddenSet) ->
    R >= 0 and R < N and C >= 0 and C < N - 1 and
    not sets:is_element({R, C}, ForbiddenSet) and
    not sets:is_element({R, C + 1}, ForbiddenSet);
is_valid_state(N, {R, C, 1}, ForbiddenSet) ->
    R >= 0 and R < N - 1 and C >= 0 and C < N and
    not sets:is_element({R, C}, ForbiddenSet) and
    not sets:is_element({R + 1, C}, ForbiddenSet).