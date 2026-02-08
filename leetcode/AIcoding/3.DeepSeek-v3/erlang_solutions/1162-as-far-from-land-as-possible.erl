-spec max_distance(Grid :: [[integer()]]) -> integer().
max_distance(Grid) ->
    N = length(Grid),
    Queue = lists:foldl(fun(I, Acc) ->
        lists:foldl(fun(J, InnerAcc) ->
            case lists:nth(J + 1, lists:nth(I + 1, Grid)) of
                1 -> [{I, J} | InnerAcc];
                0 -> InnerAcc
            end
        end, Acc, lists:seq(0, N - 1))
    end, [], lists:seq(0, N - 1)),
    case Queue of
        [] -> -1;
        _ ->
            Directions = [{-1, 0}, {1, 0}, {0, -1}, {0, 1}],
            max_distance_bfs(Queue, Grid, Directions, N)
    end.

max_distance_bfs(Queue, Grid, Directions, N) ->
    case Queue of
        [] -> -1;
        _ ->
            {NewQueue, NewGrid} = lists:foldl(fun({I, J}, {Q, G}) ->
                lists:foldl(fun({Di, Dj}, {InnerQ, InnerG}) ->
                    NewI = I + Di,
                    NewJ = J + Dj,
                    if
                        NewI >= 0, NewI < N, NewJ >= 0, NewJ < N ->
                            Row = lists:nth(NewI + 1, InnerG),
                            case lists:nth(NewJ + 1, Row) of
                                0 ->
                                    NewRow = setelement(NewJ + 1, Row, 1),
                                    NewG = setelement(NewI + 1, InnerG, NewRow),
                                    {[{NewI, NewJ} | InnerQ], NewG};
                                _ -> {InnerQ, InnerG}
                            end;
                        true -> {InnerQ, InnerG}
                    end
                end, {Q, G}, Directions)
            end, {[], Grid}, Queue),
            case NewQueue of
                [] -> 0;
                _ -> 1 + max_distance_bfs(NewQueue, NewGrid, Directions, N)
            end
    end.