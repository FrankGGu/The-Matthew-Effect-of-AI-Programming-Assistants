-module(solution).
-export([max_trailing_zeros/1]).

count_factors_acc(0, _, Acc) -> Acc;
count_factors_acc(N, Factor, Acc) when N rem Factor == 0 ->
    count_factors_acc(N div Factor, Factor, Acc + 1);
count_factors_acc(_, _, Acc) -> Acc.

count_factors(N, Factor) ->
    count_factors_acc(N, Factor, 0).

build_row_prefix_sums_array_rec(C, Cols, _, _, _, Pref2s, Pref5s) when C == Cols ->
    {Pref2s, Pref5s};
build_row_prefix_sums_array_rec(C, Cols, RowFactors, Acc2, Acc5, CurrentPref2s, CurrentPref5s) ->
    {F2, F5} = array:get(C, RowFactors),
    NewAcc2 = Acc2 + F2,
    NewAcc5 = Acc5 + F5,
    NewPref2s = array:set(C, NewAcc2, CurrentPref2s),
    NewPref5s = array:set(C, NewAcc5, CurrentPref5s),
    build_row_prefix_sums_array_rec(C + 1, Cols, RowFactors, NewAcc2, NewAcc5, NewPref2s, NewPref5s).

build_row_prefix_sums_array(RowFactors, Cols) ->
    Pref2s = array:new(Cols, 0),
    Pref5s = array:new(Cols, 0),
    build_row_prefix_sums_array_rec(0, Cols, RowFactors, 0, 0, Pref2s, Pref5s).

build_row_suffix_sums_array_rec(C, _, _, _, _, Suff2s, Suff5s) when C == -1 ->
    {Suff2s, Suff5s};
build_row_suffix_sums_array_rec(C, Cols, RowFactors, Acc2, Acc5, CurrentSuff2s, CurrentSuff5s) ->
    {F2, F5} = array:get(C, RowFactors),
    NewAcc2 = Acc2 + F2,
    NewAcc5 = Acc5 + F5,
    NewSuff2s = array:set(C, NewAcc2, CurrentSuff2s),
    NewSuff5s = array:set(C, NewAcc5, CurrentSuff5s),
    build_row_suffix_sums_array_rec(C - 1, Cols, RowFactors, NewAcc2, NewAcc5, NewSuff2s, NewSuff5s).

build_row_suffix_sums_array(RowFactors, Cols) ->
    Suff2s = array:new(Cols, 0),
    Suff5s = array:new(Cols, 0),
    build_row_suffix_sums_array_rec(Cols - 1, Cols, RowFactors, 0, 0, Suff2s, Suff5s).

max_trailing_zeros(Grid) ->
    Rows = length(Grid),
    Cols = length(hd(Grid)),

    %% 1. Precompute F2 and F5 for each cell
    FactorsGrid = array:new(Rows),
    FactorsGrid_populated = lists:foldl(fun(R_idx, CurrentFactorsGrid) ->
                                            RowList = lists:nth(R_idx + 1, Grid),
                                            FactorsRow = array:from_list([{count_factors(N, 2), count_factors(N, 5)} || N <- RowList]),
                                            array:set(R_idx, FactorsRow, CurrentFactorsGrid)
                                    end, FactorsGrid, lists:seq(0, Rows-1)),

    %% 2. Precompute row-wise prefix/suffix sums
    PrefRow2 = array:new(Rows),
    PrefRow5 = array:new(Rows),
    SuffRow2 = array:new(Rows),
    SuffRow5 = array:new(Rows),

    {PrefRow2_populated, PrefRow5_populated, SuffRow2_populated, SuffRow5_populated} =
        lists:foldl(fun(R_idx, {CurrentPrefRow2, CurrentPrefRow5, CurrentSuffRow2, CurrentSuffRow5}) ->
                        RowFactors = array:get(R_idx, FactorsGrid_populated),
                        {Pref2s, Pref5s} = build_row_prefix_sums_array(RowFactors, Cols),
                        {Suff2s, Suff5s} = build_row_suffix_sums_array(RowFactors, Cols),
                        {array:set(R_idx, Pref2s, CurrentPrefRow2),
                         array:set(R_idx, Pref5s, CurrentPrefRow5),
                         array:set(R_idx, Suff2s, CurrentSuffRow2),
                         array:set(R_idx, Suff5s, CurrentSuff5s)}
                end, {PrefRow2, PrefRow5, SuffRow2, SuffRow5}, lists:seq(0, Rows-1)),

    %% 3. Precompute column-wise prefix/suffix sums
    PrefCol2 = array:new(Rows),
    PrefCol5 = array:new(Rows),
    SuffCol2 = array:new(Rows),
    SuffCol5 = array:new(Rows),

    PrefCol2_init = lists:foldl(fun(R_idx, Arr) -> array:set(R_idx, array:new(Cols, 0), Arr) end, PrefCol2, lists:seq(0, Rows-1)),
    PrefCol5_init = lists:foldl(fun(R_idx, Arr) -> array:set(R_idx, array:new(Cols, 0), Arr) end, PrefCol5, lists:seq(0, Rows-1)),
    SuffCol2_init = lists:foldl(fun(R_idx, Arr) -> array:set(R_idx, array:new(Cols, 0), Arr) end, SuffCol2, lists:seq(0, Rows-1)),
    SuffCol5_init = lists:foldl(fun(R_idx, Arr) -> array:set(R_idx, array:new(Cols, 0), Arr) end, SuffCol5, lists:seq(0, Rows-1)),

    {PrefCol2_populated, PrefCol5_populated, SuffCol2_populated, SuffCol5_populated} =
        lists:foldl(fun(C_idx, {CurrentPrefCol2, CurrentPrefCol5, CurrentSuffCol2, CurrentSuffCol5}) ->
                        % Prefix column sums for this column C_idx
                        {_Acc2_pref, _Acc5_pref, NewPrefCol2, NewPrefCol5} =
                            lists:foldl(fun(R_idx, {Acc2, Acc5, TempPrefCol2, TempPrefCol5}) ->
                                            {F2_RC, F5_RC} = array:get(C_idx, array:get(R_idx, FactorsGrid_populated)),
                                            NewAcc2 = Acc2 + F2_RC,
                                            NewAcc5 = Acc5 + F5_RC,
                                            RowPrefCol2 = array:get(R_idx, TempPrefCol2),
                                            RowPrefCol5 = array:get(R_idx, TempPrefCol5),
                                            TempPrefCol2_updated = array:set(R_idx, array:set(C_idx, NewAcc2, RowPrefCol2), TempPrefCol2),
                                            TempPrefCol5_updated = array:set(R_idx, array:set(C_idx, NewAcc5, RowPrefCol5), TempPrefCol5),
                                            {NewAcc2, NewAcc5, TempPrefCol2_updated, TempPrefCol5_updated}
                                    end, {0, 0, CurrentPrefCol2, CurrentPrefCol5}, lists:seq(0, Rows-1)),

                        % Suffix column sums for this column C_idx
                        {_Acc2_suff, _Acc5_suff, NewSuffCol2, NewSuffCol5} =
                            lists:foldl(fun(R_idx_rev, {Acc2, Acc5, TempSuffCol2, TempSuffCol5}) ->
                                            R_idx = Rows - 1 - R_idx_rev,
                                            {F2_RC, F5_RC} = array:get(C_idx, array:get(R_idx, FactorsGrid_populated)),
                                            NewAcc2 = Acc2 + F2_RC,
                                            NewAcc5 = Acc5 + F5_RC,
                                            RowSuffCol2 = array:get(R_idx, TempSuffCol2),
                                            RowSuffCol5 = array:get(R_idx, TempSuffCol5),
                                            TempSuffCol2_updated = array:set(R_idx, array:set(C_idx, NewAcc2, RowSuffCol2), TempSuffCol2),
                                            TempSuffCol5_updated = array:set(R_idx, array:set(C_idx, NewAcc5, RowSuffCol5), TempSuffCol5),
                                            {NewAcc2, NewAcc5, TempSuffCol2_updated, TempSuffCol5_updated}
                                    end, {0, 0, CurrentSuffCol2, CurrentSuffCol5}, lists:seq(0, Rows-1)),
                        {NewPrefCol2, NewPrefCol5, NewSuffCol2, NewSuffCol5}
                end, {PrefCol2_init, PrefCol5_init, SuffCol2_init, SuffCol5_init}, lists:seq(0, Cols-1)),

    %% 4. Iterate through each cell and calculate max zeros
    MaxZeros = 0,
    lists:foldl(fun(R_idx, CurrentMax) ->
                    RowFactors = array:get(R_idx, FactorsGrid_populated),
                    CurrentPrefRow2 = array:get(R_idx, PrefRow2_populated),
                    CurrentPrefRow5 = array:get(R_idx, PrefRow5_populated),
                    CurrentSuffRow2 = array:get(R_idx, SuffRow2_populated),
                    CurrentSuffRow5 = array:get(R_idx, SuffRow5_populated),

                    CurrentPrefCol2_Row = array:get(R_idx, PrefCol2_populated),
                    CurrentPrefCol5_Row = array:get(R_idx, PrefCol5_populated),
                    CurrentSuffCol2_Row = array:get(R_idx, SuffCol2_populated),
                    CurrentSuffCol5_Row = array:get(R_idx, SuffCol5_populated),

                    lists:foldl(fun(C_idx, RowMax) ->
                                    {F2_RC, F5_RC} = array:get(C_idx, RowFactors),

                                    PrefR2_Val = array:get(C_idx, CurrentPrefRow2),
                                    PrefR5_Val = array:get(C_idx, CurrentPrefRow5),
                                    SuffR2_Val = array:get(C_idx, CurrentSuffRow2),
                                    SuffR5_Val = array:get(C_idx, CurrentSuffRow5),

                                    PrefC2_Val = array:get(C_idx, CurrentPrefCol2_Row),
                                    PrefC5_Val = array:get(C_idx, CurrentPrefCol5_Row),
                                    SuffC2_Val = array:get(C_idx, CurrentSuffCol2_Row),
                                    SuffC5_Val = array:get(C_idx, CurrentSuffCol5_Row),

                                    Zeros1 = min(PrefR2_Val + PrefC2_Val - F2_RC, PrefR5_Val + PrefC5_Val - F5_RC),
                                    Zeros2 = min(PrefR2_Val + SuffC2_Val - F2_RC, PrefR5_Val + SuffC5_Val - F5_RC),
                                    Zeros3 = min(SuffR2_Val + PrefC2_Val - F2_RC, SuffR5_Val + PrefC5_Val - F5_RC),
                                    Zeros4 = min(SuffR2_Val + SuffC2_Val - F2_RC, SuffR5_Val + SuffC5_Val - F5_RC),

                                    max(RowMax, max(Zeros1, max(Zeros2, max(Zeros3, Zeros4))))
                            end, RowMax, lists:seq(0, Cols-1))
            end, MaxZeros, lists:seq(0, Rows-1)).