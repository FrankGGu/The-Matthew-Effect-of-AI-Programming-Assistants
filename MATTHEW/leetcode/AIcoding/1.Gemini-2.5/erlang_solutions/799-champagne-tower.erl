-module(solution).
-export([champagneTower/3]).

champagneTower(Poured, QueryRow, QueryGlass) ->
    CurrentRow = [Poured],
    FinalRow = simulate_rows(0, QueryRow, CurrentRow),
    TargetGlassValue = lists:nth(QueryGlass + 1, FinalRow),
    min(1.0, TargetGlassValue).

simulate_rows(RowIndex, MaxRow, CurrentRow) when RowIndex < MaxRow ->
    NextRow = calculate_next_row(CurrentRow),
    simulate_rows(RowIndex + 1, MaxRow, NextRow);
simulate_rows(MaxRow, MaxRow, CurrentRow) ->
    CurrentRow.

calculate_next_row(CurrentRow) ->
    LenCurrentRow = length(CurrentRow),
    NextRowSize = LenCurrentRow + 1,
    [ calculate_glass_amount(C, CurrentRow) || C <- lists:seq(0, NextRowSize - 1) ].

calculate_glass_amount(C, CurrentRow) ->
    LenCurrentRow = length(CurrentRow),
    AmountFromAbove = 
        if C < LenCurrentRow ->
            GlassAboveValue = lists:nth(C + 1, CurrentRow),
            if GlassAboveValue > 1.0 -> (GlassAboveValue - 1.0) / 2.0;
               true -> 0.0
            end;
           true -> 0.0
        end,
    AmountFromAboveLeft =
        if C > 0 ->
            GlassAboveLeftValue = lists:nth(C, CurrentRow),
            if GlassAboveLeftValue > 1.0 -> (GlassAboveLeftValue - 1.0) / 2.0;
               true -> 0.0
            end;
           true -> 0.0
        end,
    AmountFromAbove + AmountFromAboveLeft.