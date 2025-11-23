-spec num_enclaves(Grid :: [[integer()]]) -> integer().
num_enclaves(Grid) ->
    M = length(Grid),
    N = length(hd(Grid)),
    Visited = [ [ false || _ <- lists:seq(1, N) ] || _ <- lists:seq(1, M) ],
    {RowBounds, ColBounds} = {{0, M - 1}, {0, N - 1}},

    Flood = fun Flood(I, J, Acc) ->
        case I < 0 orelse I > M - 1 orelse J < 0 orelse J > N - 1 orelse 
             lists:nth(I + 1, lists:nth(J + 1, Visited)) orelse 
             lists:nth(J + 1, lists:nth(I + 1, Grid)) =:= 0 of
            true -> Acc;
            false ->
                NewVisited = set_visited(I, J, Visited),
                lists:foldl(fun({Di, Dj}, Sum) -> Flood(I + Di, J + Dj, Sum) end, 
                            Acc + 1, 
                            [{-1, 0}, {1, 0}, {0, -1}, {0, 1}])
        end
    end,

    FloodEdges = fun() ->
        lists:foreach(fun(I) ->
            case lists:nth(1, lists:nth(I + 1, Grid)) of
                1 -> Flood(I, 0, 0);
                _ -> ok
            end,
            case lists:nth(N, lists:nth(I + 1, Grid)) of
                1 -> Flood(I, N - 1, 0);
                _ -> ok
            end
        end, lists:seq(0, M - 1)),

        lists:foreach(fun(J) ->
            case lists:nth(J + 1, lists:nth(1, Grid)) of
                1 -> Flood(0, J, 0);
                _ -> ok
            end,
            case lists:nth(J + 1, lists:nth(M, Grid)) of
                1 -> Flood(M - 1, J, 0);
                _ -> ok
            end
        end, lists:seq(0, N - 1))
    end,

    FloodEdges(),

    Total = lists:sum([ lists:sum(Row) || Row <- Grid ]),
    Connected = lists:sum([ Flood(I, J, 0) || I <- lists:seq(0, M - 1), 
                                             J <- lists:seq(0, N - 1),
                                             lists:nth(J + 1, lists:nth(I + 1, Grid)) =:= 1,
                                             not lists:nth(I + 1, lists:nth(J + 1, Visited)) ]),

    Total - Connected.

set_visited(I, J, Visited) ->
    Row = lists:nth(I + 1, Visited),
    NewRow = setelement(J + 1, Row, true),
    setelement(I + 1, Visited, NewRow).