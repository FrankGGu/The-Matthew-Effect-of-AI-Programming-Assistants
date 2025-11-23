-module(solution).
-export([solve/7]).

solve(N, M, StartR, StartC, EndR, EndC, K) ->
    Infinity = 1_000_000_000,

    InitialRow = [Infinity || _ <- 1..M],
    InitialLayer = [InitialRow || _ <- 1..N],
    DpTable = [InitialLayer || _ <- 0..K],

    UpdatedDpTable0 = set_value(DpTable, 0, StartR, StartC, 0),

    DR = [-1, 1, 0, 0],
    DC = [0, 0, -1, 1],

    FinalDpTable = lists:foldl(fun(K_idx, CurrentDpTable) ->
        Q_bfs_initial = lists:foldl(fun(R, AccQ) ->
            lists:foldl(fun(C, AccQ2) ->
                Val = get_value(CurrentDpTable, K_idx, R, C),
                if Val < Infinity -> queue:in({R, C}, AccQ2);
                   true -> AccQ2
                end
            end, AccQ, 0..M-1)
        end, queue:new(), 0..N-1),

        UpdatedAfterGridMoves = bfs_grid_moves_loop(N, M, K_idx, CurrentDpTable, Q_bfs_initial, DR, DC),

        if K_idx < K ->
            MinDistWithK_idx = lists:foldl(fun(R, AccMin) ->
                lists:foldl(fun(C, AccMin2) ->
                    min(AccMin2, get_value(UpdatedAfterGridMoves, K_idx, R, C))
                end, AccMin, 0..M-1)
            end, Infinity, 0..N-1),

            if MinDistWithK_idx < Infinity ->
                lists:foldl(fun(R, AccDp) ->
                    lists:foldl(fun(C, AccDp2) ->
                        CurrentVal = get_value(AccDp2, K_idx+1, R, C),
                        NewVal = min(CurrentVal, MinDistWithK_idx + 1),
                        set_value(AccDp2, K_idx+1, R, C, NewVal)
                    end, AccDp, 0..M-1)
                end, UpdatedAfterGridMoves, 0..N-1);
            true ->
                UpdatedAfterGridMoves
            end;
        true ->
            UpdatedAfterGridMoves
        end
    end, UpdatedDpTable0, 0..K),

    MinTotalOps = lists:foldl(fun(K_idx, AccMin) ->
        min(AccMin, get_value(FinalDpTable, K_idx, EndR, EndC))
    end, Infinity, 0..K),

    if MinTotalOps == Infinity -> -1;
    true -> MinTotalOps
    end.

get_value(DpTable, K_idx, R, C) ->
    lists:nth(C + 1, lists:nth(R + 1, lists:nth(K_idx + 1, DpTable))).

set_value(DpTable, K_idx, R, C, Value) ->
    Layer = lists:nth(K_idx + 1, DpTable),
    Row = lists:nth(R + 1, Layer),
    NewRow = lists:replace_at(C + 1, Value, Row),
    NewLayer = lists:replace_at(R + 1, NewRow, Layer),
    lists:replace_at(K_idx + 1, NewLayer, DpTable).

bfs_grid_moves_loop(N, M, K_idx, DpTable, Q, DR, DC) when queue:is_empty(Q) ->
    DpTable;
bfs_grid_moves_loop(N, M, K_idx, DpTable, Q, DR, DC) ->
    {{R, C}, Q_rest} = queue:out(Q),
    CurrentDist = get_value(DpTable, K_idx, R, C),

    {NewDpTable, NewQ} = lists:foldl(fun(I, {AccDpTable, AccQ}) ->
        NR = R + lists:nth(I + 1, DR),
        NC = C + lists:nth(I + 1, DC),

        if NR >= 0, NR < N, NC >= 0, NC < M ->
            NeighborDist = get_value(AccDpTable, K_idx, NR, NC),
            if NeighborDist > CurrentDist + 1 ->
                UpdatedAccDpTable = set_value(AccDpTable, K_idx, NR, NC, CurrentDist + 1),
                UpdatedAccQ = queue:in({NR, NC}, AccQ),
                {UpdatedAccDpTable, UpdatedAccQ};
            true ->
                {AccDpTable, AccQ}
            end;
        true ->
            {AccDpTable, AccQ}
        end
    end, {DpTable, Q_rest}, 0..3),

    bfs_grid_moves_loop(N, M, K_idx, NewDpTable, NewQ, DR, DC).