-module(solution).
-export([validPartition/1]).

validPartition(Nums) ->
    N = length(Nums),

    NumsArray = gb_array:from_list(Nums),

    DP = gb_array:new(N + 1, {default, false}),
    DP_initial = gb_array:set(0, true, DP),

    solve(1, N, NumsArray, DP_initial).

solve(I, N, NumsArray, DP) when I =< N ->
    CurrentDP_val = false,

    if I >= 2 ->
        NumI_1 = gb_array:get(I-1, NumsArray),
        NumI_2 = gb_array:get(I-2, NumsArray),
        if NumI_1 == NumI_2 ->
            IfPrevDP = gb_array:get(I-2, DP),
            CurrentDP_val = CurrentDP_val orelse IfPrevDP;
        true -> ok
        end;
    true -> ok
    end,

    if I >= 3 ->
        NumI_1 = gb_array:get(I-1, NumsArray),
        NumI_2 = gb_array:get(I-2, NumsArray),
        NumI_3 = gb_array:get(I-3, NumsArray),

        if NumI_1 == NumI_2 andalso NumI_2 == NumI_3 ->
            IfPrevDP = gb_array:get(I-3, DP),
            CurrentDP_val = CurrentDP_val orelse IfPrevDP;
        true -> ok
        end,

        if NumI_1 == NumI_2 + 1 andalso NumI_2 == NumI_3 + 1 ->
            IfPrevDP = gb_array:get(I-3, DP),
            CurrentDP_val = CurrentDP_val orelse IfPrevDP;
        true -> ok
        end;
    true -> ok
    end,

    NewDP = gb_array:set(I, CurrentDP_val, DP),
    solve(I+1, N, NumsArray, NewDP);
solve(I, N, NumsArray, DP) when I > N ->
    gb_array:get(N, DP).