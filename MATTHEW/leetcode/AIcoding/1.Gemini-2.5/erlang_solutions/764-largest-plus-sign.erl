-module(solution).
-export([orderOfLargestPlusSign/2]).

orderOfLargestPlusSign(N, Mines) ->
    Grid = array:new(N, array:new(N, 1)),

    GridWithMines = lists:foldl(
        fun([R, C], AccGrid) ->
            Row = array:get(R, AccGrid),
            NewRow = array:set(C, 0, Row),
            array:set(R, NewRow, AccGrid)
        end,
        Grid,
        Mines
    ),

    L = array:new(N, array:new(N, 0)),
    R = array:new(N, array:new(N, 0)),
    U = array:new(N, array:new(N, 0)),
    D = array:new(N, array:new(N, 0)),

    {L1, U1} = calculate_LU(N, GridWithMines, L, U),

    {R1, D1} = calculate_RD(N, GridWithMines, R, D),

    calculate_max_order(N, GridWithMines, L1, R1, U1, D1).

calculate_LU(N, Grid, L_init, U_init) ->
    lists:foldl(
        fun(R, {AccL, AccU}) ->
            GridRow = array:get(R, Grid),
            lists:foldl(
                fun(C, {CurrentL, CurrentU}) ->
                    Val = array:get(C, GridRow),
                    if
                        Val == 1 ->
                            LeftVal = if C > 0 -> array:get(C-1, array:get(R, CurrentL)); true -> 0 end,
                            NewLRow = array:set(C, LeftVal + 1, array:get(R, CurrentL)),
                            NewL = array:set(R, NewLRow, CurrentL),

                            UpVal = if R > 0 -> array:get(C, array:get(R-1, CurrentU)); true -> 0 end,
                            NewURow = array:set(C, UpVal + 1, array:get(R, CurrentU)),
                            NewU = array:set(R, NewURow, CurrentU),
                            {NewL, NewU};
                        true ->
                            {CurrentL, CurrentU}
                    end
                end,
                {AccL, AccU},
                lists:seq(0, N-1)
            )
        end,
        {L_init, U_init},
        lists:seq(0, N-1)
    ).

calculate_RD(N, Grid, R_init, D_init) ->
    lists:foldl(
        fun(R, {AccR, AccD}) ->
            GridRow = array:get(R, Grid),
            lists:foldl(
                fun(C, {CurrentR, CurrentD}) ->
                    Val = array:get(C, GridRow),
                    if
                        Val == 1 ->
                            RightVal = if C < N-1 -> array:get(C+1, array:get(R, CurrentR)); true -> 0 end,
                            NewRRow = array:set(C, RightVal + 1, array:get(R, CurrentR)),
                            NewR = array:set(R, NewRRow, CurrentR),

                            DownVal = if R < N-1 -> array:get(C, array:get(R+1, CurrentD)); true -> 0 end,
                            NewDRow = array:set(C, DownVal + 1, array:get(R, CurrentD)),
                            NewD = array:set(R, NewDRow, CurrentD),
                            {NewR, NewD};
                        true ->
                            {CurrentR, CurrentD}
                    end
                end,
                {AccR, AccD},
                lists:seq(N-1, 0, -1)
            )
        end,
        {R_init, D_init},
        lists:seq(N-1, 0, -1)
    ).

calculate_max_order(N, Grid, L, R, U, D) ->
    lists:foldl(
        fun(R, MaxAcc) ->
            GridRow = array:get(R, Grid),
            LRow = array:get(R, L),
            RRow = array:get(R, R),
            URow = array:get(R, U),
            DRow = array:get(R, D),
            lists:foldl(
                fun(C, MaxCurrent) ->
                    Val = array:get(C, GridRow),
                    if
                        Val == 1 ->
                            LVal = array:get(C, LRow),
                            RVal = array:get(C, RRow),
                            UVal = array:get(C, URow),
                            DVal = array:get(C, DRow),
                            Order = min(min(LVal, RVal), min(UVal, DVal)),
                            max(MaxCurrent, Order);
                        true ->
                            MaxCurrent
                    end
                end,
                MaxAcc,
                lists:seq(0, N-1)
            )
        end,
        0,
        lists:seq(0, N-1)
    ).