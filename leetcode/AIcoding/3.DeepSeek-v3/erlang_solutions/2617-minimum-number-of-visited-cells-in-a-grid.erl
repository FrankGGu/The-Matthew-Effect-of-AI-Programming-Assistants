-module(solution).
-export([minimum_visited_cells/1]).

minimum_visited_cells(Grid) ->
    M = length(Grid),
    N = length(hd(Grid)),
    Dist = lists:duplicate(M, lists:duplicate(N, -1)),
    Dist1 = setelement(1, Dist, setelement(1, element(1, Dist), 1)),
    Q = queue:from_list([{0, 0}]),
    bfs(Grid, Dist1, Q, M, N).

bfs(Grid, Dist, Q, M, N) ->
    case queue:is_empty(Q) of
        true -> -1;
        false ->
            {{value, {I, J}}, Q1} = queue:out(Q),
            D = element(I + 1, element(J + 1, Dist)),
            if
                I =:= M - 1, J =:= N - 1 -> D;
                true ->
                    Max = element(J + 1, lists:nth(I + 1, Grid)),
                    NewDist = update_neighbors(Grid, Dist, I, J, D, Max, M, N),
                    bfs(Grid, NewDist, Q1, M, N)
            end
    end.

update_neighbors(Grid, Dist, I, J, D, Max, M, N) ->
    NewDist = Dist,
    Ks = lists:seq(1, min(Max, M - I - 1)),
    NewDist1 = lists:foldl(fun(K, AccDist) ->
        NewI = I + K,
        if
            NewI < M ->
                OldD = element(NewI + 1, element(J + 1, AccDist)),
                if
                    OldD =:= -1 orelse OldD > D + 1 ->
                        NewAccDist = setelement(NewI + 1, AccDist, setelement(J + 1, element(NewI + 1, AccDist), D + 1)),
                        queue:in({NewI, J}, Q),
                        NewAccDist;
                    true -> AccDist
                end;
            true -> AccDist
        end
    end, NewDist, Ks),
    Ls = lists:seq(1, min(Max, N - J - 1)),
    lists:foldl(fun(L, AccDist) ->
        NewJ = J + L,
        if
            NewJ < N ->
                OldD = element(I + 1, element(NewJ + 1, AccDist)),
                if
                    OldD =:= -1 orelse OldD > D + 1 ->
                        NewAccDist = setelement(I + 1, AccDist, setelement(NewJ + 1, element(I + 1, AccDist), D + 1)),
                        queue:in({I, NewJ}, Q),
                        NewAccDist;
                    true -> AccDist
                end;
            true -> AccDist
        end
    end, NewDist1, Ls).