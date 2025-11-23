-module(solution).
-export([min_reverse_operations/4]).

min_reverse_operations(N, P, Banned, K) ->
    BannedSet = sets:from_list(Banned),
    Visited = array:new(N, {default, -1}),
    Queue = queue:from_list([P]),
    Visited1 = array:set(P, 0, Visited),
    process_queue(N, K, BannedSet, Queue, Visited1).

process_queue(N, K, BannedSet, Queue, Visited) ->
    case queue:is_empty(Queue) of
        true -> array:to_list(Visited);
        false ->
            {{value, Pos}, Queue1} = queue:out(Queue),
            CurrentDist = array:get(Pos, Visited),
            Start = max(0, Pos - K + 1),
            End = min(Pos, N - K),
            process_positions(N, K, BannedSet, Queue1, Visited, Pos, CurrentDist, Start, End)
    end.

process_positions(N, K, BannedSet, Queue, Visited, Pos, CurrentDist, Start, End) ->
    if
        Start > End -> process_queue(N, K, BannedSet, Queue, Visited);
        true ->
            L = Start,
            R = L + K - 1,
            NewPos = L + R - Pos,
            case (not sets:is_element(NewPos, BannedSet)) andalso (array:get(NewPos, Visited) =:= -1) of
                true ->
                    NewVisited = array:set(NewPos, CurrentDist + 1, Visited),
                    NewQueue = queue:in(NewPos, Queue),
                    process_positions(N, K, BannedSet, NewQueue, NewVisited, Pos, CurrentDist, Start + 1, End);
                false ->
                    process_positions(N, K, BannedSet, Queue, Visited, Pos, CurrentDist, Start + 1, End)
            end
    end.