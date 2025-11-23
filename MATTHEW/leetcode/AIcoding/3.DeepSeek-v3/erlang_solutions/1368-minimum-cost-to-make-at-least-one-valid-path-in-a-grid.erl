-module(solution).
-export([min_cost/1]).

min_cost(Grid) ->
    M = length(Grid),
    N = length(hd(Grid)),
    Dirs = [{0, 1}, {0, -1}, {1, 0}, {-1, 0}],
    Costs = array:new([{size, M}, {default, array:new([{size, N}, {default, infinity}])}]),
    Q = queue:from_list([{0, 0, 0}]),
    Costs1 = array:set(0, array:set(0, 0, array:get(0, Costs)), Costs),
    bfs(Grid, Q, Costs1, Dirs, M, N).

bfs(Grid, Q, Costs, Dirs, M, N) ->
    case queue:is_empty(Q) of
        true -> 
            array:get(M - 1, array:get(N - 1, Costs));
        false ->
            {{value, {X, Y, Cost}}, Q1} = queue:out(Q),
            if 
                X =:= M - 1, Y =:= N - 1 -> Cost;
                true ->
                    CostsXY = array:get(X, array:get(Y, Costs)),
                    if
                        Cost > CostsXY -> 
                            bfs(Grid, Q1, Costs, Dirs, M, N);
                        true ->
                            Dir = lists:nth(array:get(X, array:get(Y, Grid)), Dirs),
                            {Dx, Dy} = Dir,
                            NewX = X + Dx,
                            NewY = Y + Dy,
                            NewCost = Cost,
                            NewCosts = update_cost(NewX, NewY, NewCost, Costs, Q, M, N),
                            UpdatedCosts = lists:foldl(
                                fun({Dx1, Dy1}, AccCosts) ->
                                    NX = X + Dx1,
                                    NY = Y + Dy1,
                                    NC = Cost + 1,
                                    update_cost(NX, NY, NC, AccCosts, Q, M, N)
                                end, NewCosts, Dirs -- [Dir]),
                            bfs(Grid, Q1, UpdatedCosts, Dirs, M, N)
                    end
            end
    end.

update_cost(X, Y, Cost, Costs, Q, M, N) ->
    if
        X >= 0, X < M, Y >= 0, Y < N ->
            CostsXY = array:get(X, array:get(Y, Costs)),
            if
                Cost < CostsXY ->
                    NewCosts = array:set(X, array:set(Y, Cost, array:get(X, Costs)), Costs),
                    queue:in({X, Y, Cost}, Q),
                    NewCosts;
                true -> Costs
            end;
        true -> Costs
    end.