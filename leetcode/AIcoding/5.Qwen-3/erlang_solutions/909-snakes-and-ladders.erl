-module(snakes_and_ladders).
-export([jump/1]).

jump(Board) ->
    Size = length(Board),
    Queue = queue:new(),
    Visited = sets:new(),
    {Queue1, Visited1} = queue:in({1, 0}, Queue),
    jump_helper(Queue1, Visited1, Board, Size).

jump_helper(Queue, Visited, Board, Size) ->
    case queue:out(Queue) of
        {empty, _} -> -1;
        {{value, {Pos, Steps}}, NewQueue} ->
            if
                Pos == Size * Size -> Steps;
                true ->
                    NextPositions = generate_next_positions(Pos, Size),
                    {NewQueue1, Visited1} = process_next_positions(NextPositions, NewQueue, Visited, Board, Size),
                    jump_helper(NewQueue1, Visited1, Board, Size)
            end
    end.

generate_next_positions(Pos, Size) ->
    lists:seq(Pos + 1, Pos + 6).

process_next_positions([], Queue, Visited, _, _) ->
    {Queue, Visited};
process_next_positions([Pos | Rest], Queue, Visited, Board, Size) ->
    case sets:is_element(Pos, Visited) of
        true ->
            process_next_positions(Rest, Queue, Visited, Board, Size);
        false ->
            NewVisited = sets:add_element(Pos, Visited),
            NewPos = get_final_position(Pos, Board, Size),
            {NewQueue, _} = queue:in({NewPos, Steps + 1}, Queue),
            process_next_positions(Rest, NewQueue, NewVisited, Board, Size)
    end.

get_final_position(Pos, Board, Size) ->
    Row = (Pos - 1) div Size,
    Col = (Pos - 1) rem Size,
    case Row rem 2 of
        0 ->
            Board !! Row !! Col;
        1 ->
            Board !! Row !! (Size - 1 - Col)
    end.