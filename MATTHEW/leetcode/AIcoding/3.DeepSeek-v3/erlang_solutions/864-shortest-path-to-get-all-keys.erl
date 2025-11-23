-module(solution).
-export([shortest_path/1]).

shortest_path(Grid) ->
    {M, N, Start, Keys} = parse_grid(Grid),
    TotalKeys = length(Keys),
    Visited = maps:new(),
    Queue = queue:in({Start, 0, 0}, queue:new()),
    bfs(Queue, Visited, M, N, TotalKeys, Grid).

parse_grid(Grid) ->
    M = length(Grid),
    N = length(hd(Grid)),
    {Start, Keys} = lists:foldl(
        fun(Row, {SAcc, KAcc}) ->
            lists:foldl(
                fun(Cell, {S, K}) ->
                    case Cell of
                        $@ -> {{R, C}, K};
                        $a -> {S, [Cell | K]};
                        $b -> {S, [Cell | K]};
                        $c -> {S, [Cell | K]};
                        $d -> {S, [Cell | K]};
                        $e -> {S, [Cell | K]};
                        $f -> {S, [Cell | K]};
                        _ -> {S, K}
                    end
                end,
                {SAcc, KAcc},
                lists:zip(lists:seq(0, N - 1), Row)
            )
        end,
        {undefined, []},
        lists:zip(lists:seq(0, M - 1), Grid)
    ),
    {M, N, Start, Keys}.

bfs(Queue, Visited, M, N, TotalKeys, Grid) ->
    case queue:out(Queue) of
        {empty, _} -> -1;
        {{value, {{X, Y}, KeysMask, Steps}}, Q} ->
            case KeysMask =:= (1 bsl TotalKeys) - 1 of
                true -> Steps;
                false ->
                    case maps:is_key({{X, Y}, KeysMask}, Visited) of
                        true -> bfs(Q, Visited, M, N, TotalKeys, Grid);
                        false ->
                            NewVisited = maps:put({{X, Y}, KeysMask}, true, Visited),
                            NewQueue = lists:foldl(
                                fun({Dx, Dy}, AccQ) ->
                                    NX = X + Dx,
                                    NY = Y + Dy,
                                    if
                                        NX >= 0, NX < M, NY >= 0, NY < N ->
                                            Cell = lists:nth(NY + 1, lists:nth(NX + 1, Grid)),
                                            case Cell of
                                                $# -> AccQ;
                                                _ when Cell >= $A, Cell =< $F ->
                                                    case (KeysMask band (1 bsl (Cell - $A))) =/= 0 of
                                                        true -> queue:in({{NX, NY}, KeysMask, Steps + 1}, AccQ);
                                                        false -> AccQ
                                                    end;
                                                _ when Cell >= $a, Cell =< $f ->
                                                    NewKeysMask = KeysMask bor (1 bsl (Cell - $a)),
                                                    queue:in({{NX, NY}, NewKeysMask, Steps + 1}, AccQ);
                                                _ ->
                                                    queue:in({{NX, NY}, KeysMask, Steps + 1}, AccQ)
                                            end;
                                        true -> AccQ
                                    end
                                end,
                                Q,
                                [{0, 1}, {1, 0}, {0, -1}, {-1, 0}]
                            ),
                            bfs(NewQueue, NewVisited, M, N, TotalKeys, Grid)
                    end
            end
        end
    end.