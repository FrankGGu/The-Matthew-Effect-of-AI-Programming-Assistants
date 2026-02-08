-module(solution).
-export([min_area/1]).

-spec min_area(Grid :: [[integer()]]) -> integer().
min_area(Grid) ->
    InitialState = {101, -1, 101, -1, false},

    NumCols = case Grid of
                  [] -> 0;
                  [H|_] -> length(H)
              end,
    ColIndices = lists:seq(0, NumCols - 1),

    FinalState = lists:foldl(
        fun({Row, RowIdx}, {AccMinR, AccMaxR, AccMinC, AccMaxC, AccFoundOne}) ->
            lists:foldl(
                fun({ColVal, ColIdx}, {CurrentMinR, CurrentMaxR, CurrentMinC, CurrentMaxC, CurrentFoundOne}) ->
                    case ColVal of
                        1 ->
                            {min(CurrentMinR, RowIdx),
                             max(CurrentMaxR, RowIdx),
                             min(CurrentMinC, ColIdx),
                             max(CurrentMaxC, ColIdx),
                             true};
                        _ ->
                            {CurrentMinR, CurrentMaxR, CurrentMinC, CurrentMaxC, CurrentFoundOne}
                    end
                end,
                {AccMinR, AccMaxR, AccMinC, AccMaxC, AccFoundOne},
                lists:zip(Row, ColIndices)
            )
        end,
        InitialState,
        lists:zip(Grid, lists:seq(0, length(Grid) - 1))
    ),

    {MinR, MaxR, MinC, MaxC, FoundOne} = FinalState,

    case FoundOne of
        true ->
            (MaxR - MinR + 1) * (MaxC - MinC + 1);
        false ->
            0
    end.