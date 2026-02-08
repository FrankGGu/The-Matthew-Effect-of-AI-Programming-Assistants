-module(solution).
-export([count_unguarded/4]).

count_unguarded(M, N, Guards, Walls) ->
    Grid = lists:duplicate(M, lists:duplicate(N, 0)),
    Grid1 = mark_guards(Guards, Grid),
    Grid2 = mark_walls(Walls, Grid1),
    {Visited, _} = spread_guards(Guards, Grid2, M, N),
    count_zeros(Visited, M, N).

mark_guards([], Grid) -> Grid;
mark_guards([[X, Y] | Rest], Grid) ->
    Row = lists:nth(X + 1, Grid),
    NewRow = setnth(Y + 1, Row, 2),
    NewGrid = setnth(X + 1, Grid, NewRow),
    mark_guards(Rest, NewGrid).

mark_walls([], Grid) -> Grid;
mark_walls([[X, Y] | Rest], Grid) ->
    Row = lists:nth(X + 1, Grid),
    NewRow = setnth(Y + 1, Row, 3),
    NewGrid = setnth(X + 1, Grid, NewRow),
    mark_walls(Rest, NewGrid).

setnth(1, [_ | T], X) -> [X | T];
setnth(N, [H | T], X) -> [H | setnth(N - 1, T, X)].

spread_guards(Guards, Grid, M, N) ->
    Directions = [{0, 1}, {1, 0}, {0, -1}, {-1, 0}],
    Visited = lists:duplicate(M, lists:duplicate(N, false)),
    lists:foldl(fun([X, Y], {V, G}) ->
                        spread(X, Y, Directions, V, G, M, N)
                end, {Visited, Grid}, Guards).

spread(X, Y, Directions, Visited, Grid, M, N) ->
    lists:foldl(fun({Dx, Dy}, {V, G}) ->
                        spread_dir(X + Dx, Y + Dy, Dx, Dy, V, G, M, N)
                end, {Visited, Grid}, Directions).

spread_dir(X, Y, Dx, Dy, Visited, Grid, M, N) ->
    if X >= 0, X < M, Y >= 0, Y < N ->
            Row = lists:nth(X + 1, Grid),
            Cell = lists:nth(Y + 1, Row),
            if Cell == 0 ->
                    VRow = lists:nth(X + 1, Visited),
                    NewVRow = setnth(Y + 1, VRow, true),
                    NewVisited = setnth(X + 1, Visited, NewVRow),
                    spread_dir(X + Dx, Y + Dy, Dx, Dy, NewVisited, Grid, M, N);
               Cell == 2; Cell == 3 ->
                    {Visited, Grid}
            end;
       true ->
            {Visited, Grid}
    end.

count_zeros(Visited, M, N) ->
    lists:sum([lists:sum([if not V -> 1; true -> 0 end || V <- Row]) || Row <- Visited]).