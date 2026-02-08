-module(solution).
-export([subarray_or_closest/2]).

subarray_or_closest(Nums, K) ->
    N = length(Nums),
    MinDiff = infinity,
    Result = 0,
    {Result, _} = lists:foldl(fun(I, {Res, Min}) ->
        CurrentOr = 0,
        {NewRes, NewMin} = lists:foldl(fun(J, {CR, CM}) ->
            CurrentOr1 = CurrentOr bor lists:nth(J, Nums),
            Diff = abs(CurrentOr1 - K),
            if
                Diff < CM -> {CurrentOr1, Diff};
                true -> {CR, CM}
            end
        end, {Res, Min}, lists:seq(I, N)),
        if
            NewMin < Min -> {NewRes, NewMin};
            true -> {Res, Min}
        end
    end, {Result, MinDiff}, lists:seq(1, N)),
    Result.