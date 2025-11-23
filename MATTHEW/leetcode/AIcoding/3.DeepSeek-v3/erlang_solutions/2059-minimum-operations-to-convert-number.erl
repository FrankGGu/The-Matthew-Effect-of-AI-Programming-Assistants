-module(solution).
-export([minimum_operations/3]).

minimum_operations(Nums, Start, Goal) ->
    Visited = sets:new(),
    Queue = queue:in({Start, 0}, queue:new()),
    bfs(Nums, Goal, Queue, Visited).

bfs(Nums, Goal, Queue, Visited) ->
    case queue:out(Queue) of
        {empty, _} -> -1;
        {{value, {Current, Steps}}, NewQueue} ->
            if
                Current == Goal -> Steps;
                true ->
                    case sets:is_element(Current, Visited) of
                        true -> bfs(Nums, Goal, NewQueue, Visited);
                        false ->
                            NewVisited = sets:add_element(Current, Visited),
                            UpdatedQueue = lists:foldl(
                                fun(Num, Acc) ->
                                    Add = Current + Num,
                                    Sub = Current - Num,
                                    Xor = Current bxor Num,
                                    lists:foldl(
                                        fun(Next, Q) ->
                                            if
                                                Next >= 0, Next =< 1000 ->
                                                    queue:in({Next, Steps + 1}, Q);
                                                true -> Q
                                            end
                                        end,
                                        Acc,
                                        [Add, Sub, Xor]
                                    )
                                end,
                                NewQueue,
                                Nums
                            ),
                            bfs(Nums, Goal, UpdatedQueue, NewVisited)
                    end
            end
    end.