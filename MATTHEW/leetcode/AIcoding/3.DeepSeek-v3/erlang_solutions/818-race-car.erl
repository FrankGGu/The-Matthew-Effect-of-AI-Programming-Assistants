-module(race_car).
-export([racecar/1]).

racecar(Target) ->
    {Visited, Queue} = {sets:new(), queue:in({0, 1, 0}, queue:new())},
    bfs(Target, Visited, Queue).

bfs(Target, Visited, Queue) ->
    case queue:out(Queue) of
        {empty, _} -> -1;
        {{value, {Pos, Speed, Steps}}, Q} ->
            case Pos of
                Target -> Steps;
                _ ->
                    case sets:is_element({Pos, Speed}, Visited) of
                        true -> bfs(Target, Visited, Q);
                        false ->
                            NewVisited = sets:add_element({Pos, Speed}, Visited),
                            Q1 = queue:in({Pos + Speed, Speed * 2, Steps + 1}, Q),
                            Q2 = case Speed > 0 of
                                   true -> queue:in({Pos, -1, Steps + 1}, Q1);
                                   false -> queue:in({Pos, 1, Steps + 1}, Q1)
                                 end,
                            bfs(Target, NewVisited, Q2)
                    end
            end
    end.