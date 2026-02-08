-module(solution).
-export([max_score/1]).

max_score(Grid) ->
    InitialMaxScore = 0,

    GridRow0 = hd(Grid),
    {MaxScoreAfterRow0, MinValPrefixRow0} = process_first_row(GridRow0, InitialMaxScore),

    {FinalMaxScore, _} = lists:foldl(fun(GridRow, {AccMaxScore, PrevRowMinVals}) ->
                                        process_row(GridRow, PrevRowMinVals, AccMaxScore)
                                    end, {MaxScoreAfterRow0, MinValPrefixRow0}, tl(Grid)),
    FinalMaxScore.

process_first_row(GridRow, AccInitialMaxScore) ->
    lists:mapaccum(fun(GridVal, {AccMaxScore, LastMinVal}) ->
                        NewMinVal = min(GridVal, LastMinVal),
                        NewMaxScore = max(AccMaxScore, GridVal - LastMinVal),
                        {NewMaxScore, NewMinVal}
                    end, {AccInitialMaxScore, 100001}, GridRow).

process_row(GridRow, PrevRowMinVals, AccCurrentMaxScore) ->
    ZippedRow = lists:zip(GridRow, PrevRowMinVals),

    lists:mapaccum(fun({GridVal, PrevRowMinVal}, {AccMaxScore, LastMinValInCurrRow}) ->
                        NewMinVal = min(GridVal, min(PrevRowMinVal, LastMinValInCurrRow)),

                        Score = GridVal - min(PrevRowMinVal, LastMinValInCurrRow),
                        NewMaxScore = max(AccMaxScore, Score),

                        {NewMaxScore, NewMinVal}
                    end, {AccCurrentMaxScore, 100001}, ZippedRow).