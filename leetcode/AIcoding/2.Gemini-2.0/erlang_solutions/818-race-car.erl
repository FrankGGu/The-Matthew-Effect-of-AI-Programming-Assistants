-module(race_car).
-export([race_car/1]).

race_car(target) ->
    queue_bfs(queue:new(), target).

queue_bfs(Queue, Target) ->
    Queue1 = queue:in({0, 1, 0}, Queue),
    queue_bfs_helper(Queue1, Target, #{ {0, 1} => 0 }).

queue_bfs_helper(Queue, Target, Visited) ->
    case queue:is_empty(Queue) of
        true ->
            infinity;
        false ->
            { {value, {Pos, Speed, Steps}}, Queue2 } = queue:out(Queue),
            if Pos =:= Target then
                Steps
            else
                Key = {Pos, Speed},
                case maps:is_key(Key, Visited) of
                    true ->
                        queue_bfs_helper(Queue2, Target, Visited);
                    false ->
                        NewVisited = maps:put(Key, Steps, Visited),

                        Pos1 = Pos + Speed,
                        Speed1 = Speed * 2,
                        Queue3 = queue:in({Pos1, Speed1, Steps+1}, Queue2),

                        if Speed > 0 then
                            Speed2 = -1
                        else
                            Speed2 = 1
                        end,
                        Queue4 = queue:in({Pos, Speed2, Steps+1}, Queue3),

                        queue_bfs_helper(Queue4, Target, NewVisited)
                end
            end
    end.

infinity ->
    infinity.