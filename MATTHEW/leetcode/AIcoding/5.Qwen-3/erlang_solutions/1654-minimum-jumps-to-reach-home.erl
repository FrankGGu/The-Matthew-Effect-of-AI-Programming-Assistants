-module(minimum_jumps_to_reach_home).
-export([jumpGame/2]).

jumpGame(Jump, Obstacle) ->
    N = length(Jump),
    MaxReach = N - 1,
    Visited = sets:new(),
    Queue = queue:from_list([{0, 0}]),
    jumpGame(Jump, Obstacle, MaxReach, Visited, Queue).

jumpGame(_, _, MaxReach, _, Queue) when queue:is_empty(Queue) ->
    -1;

jumpGame(Jump, Obstacle, MaxReach, Visited, Queue) ->
    {Pos, Steps} = queue:out(Queue),
    case Pos of
        MaxReach -> Steps;
        _ ->
            case sets:is_element(Pos, Visited) of
                true -> jumpGame(Jump, Obstacle, MaxReach, Visited, Queue);
                false ->
                    NewVisited = sets:add_element(Pos, Visited),
                    NextPositions = lists:seq(1, Jump:element(Pos + 1)),
                    NewQueue = lists:foldl(
                        fun(Step, Q) ->
                            NextPos = Pos + Step,
                            if
                                NextPos =< MaxReach andalso not sets:is_element(NextPos, Visited) andalso not lists:member(NextPos, Obstacle) ->
                                    queue:in({NextPos, Steps + 1}, Q);
                                true ->
                                    Q
                            end
                        end,
                        Queue,
                        NextPositions
                    ),
                    jumpGame(Jump, Obstacle, MaxReach, NewVisited, NewQueue)
            end
    end.