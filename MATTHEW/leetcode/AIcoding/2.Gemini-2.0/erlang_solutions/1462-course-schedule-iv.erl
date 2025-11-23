-module(course_schedule_iv).
-export([checkIfPrerequisite/3]).

checkIfPrerequisite(N, Prerequisites, Queries) ->
    Adj = lists:foldl(fun([U, V], Acc) ->
                              maps:update_with(U, fun(L) -> [V | L] end, [V], Acc)
                      end, #{}, Prerequisites),
    Reachable = maps:from_list([{I, bfs(I, Adj, N)} || I <- lists:seq(1, N)]),
    [lists:member(V, maps:get(U, Reachable, [])) || [U, V] <- Queries].

bfs(Start, Adj, N) ->
    Queue = queue:new(),
    Queue1 = queue:in(Start, Queue),
    Visited = sets:add_element(Start, sets:new()),
    bfs_helper(Adj, Queue1, Visited, []).

bfs_helper(Adj, Queue, Visited, Acc) ->
    case queue:is_empty(Queue) of
        true ->
            lists:usort(Acc);
        false ->
            {Value, Queue1} = queue:out(Queue),
            Neighbors = maps:get(Value, Adj, []),
            {NewQueue, NewVisited, NewAcc} = lists:foldl(fun(Neighbor, {Q, V, A}) ->
                                                             case sets:is_element(Neighbor, V) of
                                                                 true ->
                                                                     {Q, V, A};
                                                                 false ->
                                                                     {queue:in(Neighbor, Q), sets:add_element(Neighbor, V), [Neighbor | A]}
                                                             end
                                                         end, {Queue1, Visited, Acc}, Neighbors),
            bfs_helper(Adj, NewQueue, NewVisited, NewAcc)
    end.