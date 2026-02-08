-module(grid_illumination).
-export([grid_illumination/3]).

grid_illumination(_N, LampsList, QueriesList) ->
    InitialState = init_state(LampsList),
    {_FinalState, Results} = lists:mapaccum(fun(Query, State) -> process_query(Query, State) end, InitialState, QueriesList),
    Results.

init_state(LampsList) ->
    UniqueLampsSet = lists:foldl(fun(Lamp, Acc) -> sets:add_element(Lamp, Acc) end, sets:new(), LampsList),
    Lamps = UniqueLampsSet,
    Rows = maps:new(),
    Cols = maps:new(),
    Diags1 = maps:new(), % r - c
    Diags2 = maps:new(), % r + c

    sets:fold(
        fun({R, C}, {CurrentLamps, CurrentRows, CurrentCols, CurrentDiags1, CurrentDiags2}) ->
            NewRows = maps:update_with(R, fun(V) -> V + 1 end, 1, CurrentRows),
            NewCols = maps:update_with(C, fun(V) -> V + 1 end, 1, CurrentCols),
            NewDiags1 = maps:update_with(R - C, fun(V) -> V + 1 end, 1, CurrentDiags1),
            NewDiags2 = maps:update_with(R + C, fun(V) -> V + 1 end, 1, CurrentDiags2),
            {CurrentLamps, NewRows, NewCols, NewDiags1, NewDiags2}
        end,
        {Lamps, Rows, Cols, Diags1, Diags2},
        Lamps
    ).

process_query({QR, QC}, {Lamps, Rows, Cols, Diags1, Diags2}) ->
    IsIlluminated = (maps:get(QR, Rows, 0) > 0) or
                    (maps:get(QC, Cols, 0) > 0) or
                    (maps:get(QR - QC, Diags1, 0) > 0) or
                    (maps:get(QR + QC, Diags2, 0) > 0),

    UpdatedState = lists:foldl(
        fun({DR, DC}, {CurrentLamps, CurrentRows, CurrentCols, CurrentDiags1, CurrentDiags2}) ->
            LampR = QR + DR,
            LampC = QC + DC,
            LampPos = {LampR, LampC},

            if sets:is_element(LampPos, CurrentLamps) ->
                UpdatedLamps = sets:del_element(LampPos, CurrentLamps),
                UpdatedRows = maps:update_with(LampR, fun(V) -> V - 1 end, CurrentRows),
                UpdatedCols = maps:update_with(LampC, fun(V) -> V - 1 end, CurrentCols),
                UpdatedDiags1 = maps:update_with(LampR - LampC, fun(V) -> V - 1 end, CurrentDiags1),
                UpdatedDiags2 = maps:update_with(LampR + LampC, fun(V) -> V - 1 end, CurrentDiags2),
                {UpdatedLamps, UpdatedRows, UpdatedCols, UpdatedDiags1, UpdatedDiags2}
            else
                {CurrentLamps, CurrentRows, CurrentCols, CurrentDiags1, CurrentDiags2}
            end
        end,
        {Lamps, Rows, Cols, Diags1, Diags2},
        [{-1,-1}, {-1,0}, {-1,1}, {0,-1}, {0,0}, {0,1}, {1,-1}, {1,0}, {1,1}]
    ),

    {IsIlluminated, UpdatedState}.