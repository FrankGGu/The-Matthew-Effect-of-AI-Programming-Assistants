-spec color_border(Grid :: [[integer()]], Row :: integer(), Col :: integer(), Color :: integer()) -> [[integer()]].
color_border(Grid, Row, Col, Color) ->
    M = length(Grid),
    N = length(hd(Grid)),
    OriginalColor = lists:nth(Col + 1, lists:nth(Row + 1, Grid)),
    Visited = sets:new(),
    Queue = queue:from_list([{Row, Col}]),
    Border = sets:new(),
    NewVisited = bfs(Grid, M, N, OriginalColor, Queue, Visited, Border),
    Result = lists:map(fun(R) ->
        lists:map(fun(C) ->
            case sets:is_element({R, C}, NewVisited) of
                true -> Color;
                false -> lists:nth(C + 1, lists:nth(R + 1, Grid))
            end
        end, lists:seq(0, N - 1))
    end, lists:seq(0, M - 1)),
    Result.

bfs(Grid, M, N, OriginalColor, Queue, Visited, Border) ->
    case queue:is_empty(Queue) of
        true -> Visited;
        false ->
            {{value, {R, C}}, NewQueue} = queue:out(Queue),
            case sets:is_element({R, C}, Visited) of
                true -> bfs(Grid, M, N, OriginalColor, NewQueue, Visited, Border);
                false ->
                    IsBorder = R =:= 0 orelse R =:= M - 1 orelse C =:= 0 orelse C =:= N - 1 orelse
                               lists:nth(C + 1 + 1, lists:nth(R + 1, Grid)) =/= OriginalColor orelse
                               lists:nth(C + 1 - 1, lists:nth(R + 1, Grid)) =/= OriginalColor orelse
                               (R > 0 andalso lists:nth(C + 1, lists:nth(R + 1 - 1, Grid)) =/= OriginalColor) orelse
                               (R < M - 1 andalso lists:nth(C + 1, lists:nth(R + 1 + 1, Grid)) =/= OriginalColor),
                    NewVisited = sets:add_element({R, C}, Visited),
                    NewBorder = case IsBorder of
                        true -> sets:add_element({R, C}, Border);
                        false -> Border
                    end,
                    Directions = [{0, 1}, {1, 0}, {0, -1}, {-1, 0}],
                    Adjacent = lists:filtermap(fun({DR, DC}) ->
                        NewR = R + DR,
                        NewC = C + DC,
                        if
                            NewR >= 0, NewR < M, NewC >= 0, NewC < N ->
                                case lists:nth(NewC + 1, lists:nth(NewR + 1, Grid)) of
                                    OriginalColor -> {true, {NewR, NewC}};
                                    _ -> false
                                end;
                            true -> false
                        end
                    end, Directions),
                    UpdatedQueue = lists:foldl(fun(Pos, Q) -> queue:in(Pos, Q) end, NewQueue, Adjacent),
                    bfs(Grid, M, N, OriginalColor, UpdatedQueue, NewVisited, NewBorder)
            end
    end.