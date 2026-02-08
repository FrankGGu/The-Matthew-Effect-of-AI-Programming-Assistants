-module(solution).
-export([countSubIslands/2]).

get_val(R, C, Grid) ->
    lists:nth(C + 1, lists:nth(R + 1, Grid)).

dfs(R, C, Grid1, Grid2, Rows, Cols, VisitedSet) ->
    if
        R < 0; R >= Rows; C < 0; C >= Cols ->
            {true, VisitedSet};
        get_val(R, C, Grid2) == 0 ->
            {true, VisitedSet};
        gb_sets:is_member({R, C}, VisitedSet) ->
            {true, VisitedSet}
    else
        NewVisitedSet = gb_sets:add({R, C}, VisitedSet),

        CurrentCellIsSub = (get_val(R, C, Grid1) == 1),

        {Sub1, Visited1} = dfs(R + 1, C, Grid1, Grid2, Rows, Cols, NewVisitedSet),
        {Sub2, Visited2} = dfs(R - 1, C, Grid1, Grid2, Rows, Cols, Visited1),
        {Sub3, Visited3} = dfs(R, C + 1, Grid1, Grid2, Rows, Cols, Visited2),
        {Sub4, Visited4} = dfs(R, C - 1, Grid1, Grid2, Rows, Cols, Visited3),

        {CurrentCellIsSub and Sub1 and Sub2 and Sub3 and Sub4, Visited4}
    end.

countSubIslands(Grid1, Grid2) ->
    Rows = length(Grid1),
    Cols = length(hd(Grid1)),
    InitialVisitedSet = gb_sets:empty(),
    InitialState = {0, InitialVisitedSet},

    {FinalCount, _FinalVisitedSet} = lists:foldl(fun(R, {CurrentCount, CurrentVisitedSet}) ->
        lists:foldl(fun(C, {InnerCount, InnerVisitedSet}) ->
            if
                get_val(R, C, Grid2) == 1 andalso not gb_sets:is_member({R, C}, InnerVisitedSet) ->
                    {IsSub, NewVisitedSet} = dfs(R, C, Grid1, Grid2, Rows, Cols, InnerVisitedSet),
                    if
                        IsSub -> {InnerCount + 1, NewVisitedSet};
                        true -> {InnerCount, NewVisitedSet}
                    end;
                true ->
                    {InnerCount, InnerVisitedSet}
            end
        end, {CurrentCount, CurrentVisitedSet}, lists:seq(0, Cols - 1))
    end, InitialState, lists:seq(0, Rows - 1)),
    FinalCount.