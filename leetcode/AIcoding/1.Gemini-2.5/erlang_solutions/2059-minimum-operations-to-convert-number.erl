-module(solution).
-export([minimumOperations/3]).

minimumOperations(Nums, Start, Goal) ->
    if Start == Goal -> 0;
       true -> bfs(Nums, Start, Goal)
    end.

bfs(Nums, Start, Goal) ->
    Q = queue:from_list([{Start, 0}]),
    Visited = gb_sets:add(Start, gb_sets:new()),
    bfs_loop(Q, Visited, Nums, Goal).

bfs_loop(Q, Visited, Nums, Goal) ->
    case queue:out(Q) of
        {{value, {Curr, Steps}}, DequeuedQ} ->
            NextStates = lists:flatmap(fun(X) ->
                [Curr + X, Curr - X, Curr bxor X]
            end, Nums),

            {NewQ, NewVisited, GoalFoundSteps} = lists:foldl(fun(Next, {AccQ, AccVisited, FoundSteps}) ->
                if FoundSteps /= -1 ->
                    {AccQ, AccVisited, FoundSteps};
                true ->
                    if Next == Goal ->
                        {AccQ, AccVisited, Steps + 1};
                    true ->
                        if Next >= 0 andalso Next =< 1000 ->
                            if not gb_sets:is_element(Next, AccVisited) ->
                                {queue:in({Next, Steps + 1}, AccQ), gb_sets:add(Next, AccVisited), -1};
                            true ->
                                {AccQ, AccVisited, -1}
                            end;
                        true ->
                            {AccQ, AccVisited, -1}
                        end
                    end
                end
            end, {DequeuedQ, Visited, -1}, NextStates),

            if GoalFoundSteps /= -1 ->
                GoalFoundSteps;
            true ->
                bfs_loop(NewQ, NewVisited, Nums, Goal)
            end;
        {empty, _} ->
            -1
    end.