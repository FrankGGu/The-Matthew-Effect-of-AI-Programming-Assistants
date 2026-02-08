-module(snakes_and_ladders).
-export([snakes_and_ladders/1]).

snakes_and_ladders(Board) ->
    N = length(Board),
    Target = N * N,
    Visited = array:new([{size, Target + 1}, {default, false}]),
    Queue = queue:from_list([1]),
    Visited1 = array:set(1, true, Visited),
    bfs(Board, Queue, Visited1, 1, N).

bfs(Board, Queue, Visited, Steps, N) ->
    case queue:is_empty(Queue) of
        true -> -1;
        false ->
            {NewQueue, NewVisited} = process_level(Board, Queue, Visited, Steps, N),
            bfs(Board, NewQueue, NewVisited, Steps + 1, N)
    end.

process_level(Board, Queue, Visited, Steps, N) ->
    Size = queue:len(Queue),
    process_cells(Board, Queue, Visited, Steps, N, Size, queue:new(), Visited).

process_cells(_Board, Queue, Visited, _Steps, _N, 0, AccQueue, AccVisited) ->
    {AccQueue, AccVisited};
process_cells(Board, Queue, Visited, Steps, N, Count, AccQueue, AccVisited) ->
    {{value, Pos}, RestQueue} = queue:out(Queue),
    NextPositions = lists:seq(Pos + 1, min(Pos + 6, N * N)),
    {NewAccQueue, NewAccVisited} = process_next_positions(Board, NextPositions, N, AccQueue, AccVisited),
    process_cells(Board, RestQueue, Visited, Steps, N, Count - 1, NewAccQueue, NewAccVisited).

process_next_positions(Board, [Pos | Rest], N, AccQueue, AccVisited) ->
    case array:get(Pos, AccVisited) of
        false ->
            {Row, Col} = get_coordinates(Pos, N),
            Value = lists:nth(Col, lists:nth(Row, Board)),
            NewPos = if
                Value =/= -1 -> Value;
                true -> Pos
            end,
            if
                NewPos =:= N * N -> {queue:from_list([NewPos]), AccVisited};
                true ->
                    NewVisited = array:set(Pos, true, AccVisited),
                    NewQueue = queue:in(NewPos, AccQueue),
                    process_next_positions(Board, Rest, N, NewQueue, NewVisited)
            end;
        true ->
            process_next_positions(Board, Rest, N, AccQueue, AccVisited)
    end;
process_next_positions(_Board, [], _N, AccQueue, AccVisited) ->
    {AccQueue, AccVisited}.

get_coordinates(Pos, N) ->
    Row = N - ((Pos - 1) div N),
    Col = case (N - Row) rem 2 of
        0 -> (Pos - 1) rem N + 1;
        1 -> N - ((Pos - 1) rem N)
    end,
    {Row, Col}.