-module(solution).
-export([is_escape_possible/2]).

is_escape_possible(Blocked, Source, Target) ->
    MaxSteps = 20000,
    BlockedSet = sets:from_list(Blocked),
    case {can_reach(Source, Target, BlockedSet, MaxSteps), can_reach(Target, Source, BlockedSet, MaxSteps)} of
        {true, true} -> true;
        _ -> false
    end.

can_reach(Start, End, Blocked, MaxSteps) ->
    Visited = sets:new(),
    Queue = queue:in(Start, queue:new()),
    can_reach_bfs(End, Blocked, MaxSteps, Visited, Queue).

can_reach_bfs(End, Blocked, MaxSteps, Visited, Queue) ->
    case queue:is_empty(Queue) of
        true -> false;
        false ->
            {{value, {X, Y}}, NewQueue} = queue:out(Queue),
            if
                {X, Y} == End -> true;
                sets:size(Visited) >= MaxSteps -> true;
                true ->
                    case sets:is_element({X, Y}, Visited) of
                        true -> can_reach_bfs(End, Blocked, MaxSteps, Visited, NewQueue);
                        false ->
                            NewVisited = sets:add_element({X, Y}, Visited),
                            Neighbors = [{X+1, Y}, {X-1, Y}, {X, Y+1}, {X, Y-1}],
                            ValidNeighbors = lists:filter(fun({NX, NY}) ->
                                NX >= 0 andalso NX < 1000000 andalso NY >= 0 andalso NY < 1000000 andalso
                                not sets:is_element({NX, NY}, Blocked)
                            end, Neighbors),
                            UpdatedQueue = lists:foldl(fun(N, Q) -> queue:in(N, Q) end, NewQueue, ValidNeighbors),
                            can_reach_bfs(End, Blocked, MaxSteps, NewVisited, UpdatedQueue)
                    end
            end
    end.