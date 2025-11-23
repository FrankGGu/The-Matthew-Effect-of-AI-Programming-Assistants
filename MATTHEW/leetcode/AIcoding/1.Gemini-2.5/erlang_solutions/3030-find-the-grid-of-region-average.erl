-module(solution).
-export([average_grid/2]).

average_grid(Grid, Threshold) ->
    M = length(Grid),
    N = length(hd(Grid)),

    SumMap = #{},
    CountMap = #{},

    PossibleCenters = [ {R, C} || R <- lists:seq(1, M-2), C <- lists:seq(1, N-2) ],

    {FinalSumMap, FinalCountMap} = lists:foldl(
        fun({R_center, C_center}, {CurrentSumMap, CurrentCountMap}) ->
            if check_region_validity(Grid, R_center, C_center, Threshold) ->
                RegionSum = calculate_region_sum(Grid, R_center, C_center),
                Average = RegionSum div 9,
                R_start = R_center - 1,
                R_end = R_center + 1,
                C_start = C_center - 1,
                C_end = C_center + 1,

                lists:foldl(
                    fun({R_idx, C_idx}, {AccSumMap, AccCountMap}) ->
                        Key = {R_idx, C_idx},
                        NewAccSumMap = maps:update_with(Key, fun(OldSum) -> OldSum + Average end, Average, AccSumMap),
                        NewAccCountMap = maps:update_with(Key, fun(OldCount) -> OldCount + 1 end, 1, AccCountMap),
                        {NewAccSumMap, NewAccCountMap}
                    end,
                    {CurrentSumMap, CurrentCountMap},
                    [ {R_idx, C_idx} || R_idx <- lists:seq(R_start, R_end), C_idx <- lists:seq(C_start, C_end) ]
                );
            true ->
                {CurrentSumMap, CurrentCountMap}
            end
        end,
        {SumMap, CountMap},
        PossibleCenters
    ),

    [ [ calculate_final_cell_value(R, C, Grid, FinalSumMap, FinalCountMap)
        || C <- lists:seq(0, N-1) ]
      || R <- lists:seq(0, M-1) ].

get_cell(Grid, R, C) ->
    lists:nth(C + 1, lists:nth(R + 1, Grid)).

check_region_validity(Grid, R_center, C_center, Threshold) ->
    R_start = R_center - 1,
    R_end = R_center + 1,
    C_start = C_center - 1,
    C_end = C_center + 1,

    HorizontalPairs = [ {get_cell(Grid, R_idx, C_idx), get_cell(Grid, R_idx, C_idx+1)}
                        || R_idx <- lists:seq(R_start, R_end),
                           C_idx <- lists:seq(C_start, C_end-1) ],

    VerticalPairs = [ {get_cell(Grid, R_idx, C_idx), get_cell(Grid, R_idx+1, C_idx)}
                      || R_idx <- lists:seq(R_start, R_end-1),
                         C_idx <- lists:seq(C_start, C_end) ],

    AllPairs = HorizontalPairs ++ VerticalPairs,
    lists:all(fun({V1, V2}) -> abs(V1 - V2) =< Threshold end, AllPairs).

calculate_region_sum(Grid, R_center, C_center) ->
    R_start = R_center - 1,
    R_end = R_center + 1,
    C_start = C_center - 1,
    C_end = C_center + 1,
    lists:sum([ get_cell(Grid, R_idx, C_idx)
                || R_idx <- lists:seq(R_start, R_end),
                   C_idx <- lists:seq(C_start, C_end) ]).

calculate_final_cell_value(R, C, Grid, SumMap, CountMap) ->
    Key = {R, C},
    case maps:find(Key, CountMap) of
        {ok, Count} when Count > 0 ->
            Sum = maps:get(Key, SumMap),
            Sum div Count;
        _ ->
            get_cell(Grid, R, C)
    end.