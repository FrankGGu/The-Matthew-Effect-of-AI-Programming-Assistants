-spec wardrobe_organization(M :: integer(), N :: integer(), K :: integer()) -> integer().
wardrobe_organization(M, N, K) ->
    Visited = sets:new(),
    Queue = queue:from_list([{0, 0}]),
    bfs(M, N, K, Queue, Visited, 0).

bfs(M, N, K, Queue, Visited, Count) ->
    case queue:is_empty(Queue) of
        true -> Count;
        false ->
            {{value, {X, Y}}, NewQueue} = queue:out(Queue),
            case sets:is_element({X, Y}, Visited) of
                true -> bfs(M, N, K, NewQueue, Visited, Count);
                false ->
                    case (digit_sum(X) + digit_sum(Y)) =< K of
                        false -> bfs(M, N, K, NewQueue, Visited, Count);
                        true ->
                            NewVisited = sets:add_element({X, Y}, Visited),
                            NewCount = Count + 1,
                            Directions = [{0, 1}, {1, 0}],
                            UpdatedQueue = lists:foldl(
                                fun({Dx, Dy}, Acc) ->
                                    NewX = X + Dx,
                                    NewY = Y + Dy,
                                    if
                                        NewX < M, NewY < N -> queue:in({NewX, NewY}, Acc);
                                        true -> Acc
                                    end
                                end, NewQueue, Directions),
                            bfs(M, N, K, UpdatedQueue, NewVisited, NewCount)
                    end
            end
    end.

digit_sum(N) ->
    digit_sum(N, 0).

digit_sum(0, Sum) -> Sum;
digit_sum(N, Sum) ->
    digit_sum(N div 10, Sum + (N rem 10)).