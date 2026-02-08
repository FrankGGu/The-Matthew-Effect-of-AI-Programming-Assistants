-module(solution).
-export([latest_day_to_cross/3]).

latest_day_to_cross(Row, Col, Cells) ->
    Left = 0,
    Right = length(Cells),
    lists:foldl(
        fun(_, {L, R}) when L >= R -> {L, R};
           (_, {L, R}) ->
            Mid = (L + R) div 2,
            case can_cross(Row, Col, Cells, Mid) of
                true -> {Mid + 1, R};
                false -> {L, Mid}
            end
        end,
        {Left, Right},
        lists:seq(1, 20)
    ),
    Left.

can_cross(Row, Col, Cells, Day) ->
    Grid = lists:foldl(
        fun({R, C}, Acc) ->
            maps:put({R, C}, 1, Acc)
        end,
        #{},
        lists:sublist(Cells, Day)
    ),
    Queue = lists:filtermap(
        fun(C) ->
            case maps:is_key({1, C}, Grid) of
                false -> {true, {1, C}};
                true -> false
            end
        end,
        lists:seq(1, Col)
    ),
    Visited = lists:foldl(
        fun(Pos, Acc) -> maps:put(Pos, true, Acc) end,
        #{},
        Queue
    ),
    bfs(Queue, Grid, Visited, Row, Col).

bfs([], _, _, _, _) -> false;
bfs(Queue, Grid, Visited, Row, Col) ->
    NewQueue = lists:foldl(
        fun({R, C}, Acc) ->
            if
                R =:= Row -> throw(found);
                true -> ok
            end,
            lists:foldl(
                fun({Dr, Dc}, Acc1) ->
                    NR = R + Dr,
                    NC = C + Dc,
                    if
                        NR >= 1, NR =< Row, NC >= 1, NC =< Col ->
                            case {maps:is_key({NR, NC}, Grid), maps:is_key({NR, NC}, Visited)} of
                                {false, false} ->
                                    maps:put({NR, NC}, true, Visited),
                                    [{NR, NC} | Acc1];
                                _ -> Acc1
                            end;
                        true -> Acc1
                    end
                end,
                Acc,
                [{0, 1}, {0, -1}, {1, 0}, {-1, 0}]
            )
        end,
        [],
        Queue
    ),
    try bfs(NewQueue, Grid, Visited, Row, Col) of
        Res -> Res
    catch
        found -> true
    end.