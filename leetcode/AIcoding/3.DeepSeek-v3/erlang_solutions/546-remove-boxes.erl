-module(solution).
-export([removeBoxes/1]).

removeBoxes(Boxes) ->
    N = length(Boxes),
    DP = maps:new(),
    {Result, _} = dfs(Boxes, 0, N - 1, 0, DP),
    Result.

dfs(Boxes, I, J, K, DP) ->
    case maps:find({I, J, K}, DP) of
        {ok, Val} ->
            {Val, DP};
        error ->
            if
                I > J ->
                    {0, DP};
                true ->
                    {BoxesList, _} = lists:split(J + 1, Boxes),
                    Box = lists:nth(I + 1, BoxesList),
                    I1 = I,
                    TmpK = K,
                    {NewI, NewK, DP1} = skipSameBoxes(Boxes, I1, J, Box, TmpK, DP),
                    {Res1, DP2} = dfs(Boxes, NewI + 1, J, 0, DP1),
                    Current = (NewK + 1) * (NewK + 1) + Res1,
                    {Res2, DP3} = tryMerge(Boxes, NewI, J, NewK, DP2),
                    MaxVal = max(Current, Res2),
                    NewDP = maps:put({I, J, K}, MaxVal, DP3),
                    {MaxVal, NewDP}
            end
    end.

skipSameBoxes(Boxes, I, J, Box, K, DP) ->
    if
        I > J ->
            {I, K, DP};
        true ->
            {BoxesList, _} = lists:split(J + 1, Boxes),
            CurrentBox = lists:nth(I + 1, BoxesList),
            if
                CurrentBox == Box ->
                    skipSameBoxes(Boxes, I + 1, J, Box, K + 1, DP);
                true ->
                    {I, K, DP}
            end
    end.

tryMerge(Boxes, I, J, K, DP) ->
    MaxVal = 0,
    {Res, NewDP} = tryMergeHelper(Boxes, I, J, K, I + 1, MaxVal, DP),
    {Res, NewDP}.

tryMergeHelper(Boxes, I, J, K, M, CurrentMax, DP) ->
    if
        M > J ->
            {CurrentMax, DP};
        true ->
            {BoxesList, _} = lists:split(J + 1, Boxes),
            BoxI = lists:nth(I + 1, BoxesList),
            BoxM = lists:nth(M + 1, BoxesList),
            if
                BoxI == BoxM ->
                    {Res1, DP1} = dfs(Boxes, I + 1, M - 1, 0, DP),
                    {Res2, DP2} = dfs(Boxes, M, J, K + 1, DP1),
                    NewMax = max(CurrentMax, Res1 + Res2),
                    tryMergeHelper(Boxes, I, J, K, M + 1, NewMax, DP2);
                true ->
                    tryMergeHelper(Boxes, I, J, K, M + 1, CurrentMax, DP)
            end
    end.