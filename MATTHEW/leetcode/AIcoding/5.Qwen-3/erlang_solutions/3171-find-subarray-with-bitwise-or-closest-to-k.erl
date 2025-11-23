-module(solution).
-export([subarray_closest/2]).

subarray_closest(Nums, K) ->
    N = length(Nums),
    MinDiff = infinity,
    Result = -1,
    lists:foldl(fun(I, {MinDiffAcc, ResultAcc}) ->
        Current = element(I+1, Nums),
        NewSet = [Current],
        FoldResult = lists:foldl(fun(J, Acc) ->
            case Acc of
                [] -> [];
                _ ->
                    lists:foldl(fun(X, Acc2) ->
                        NewVal = X bor Current,
                        [NewVal | Acc2]
                    end, NewSet, Acc)
            end
        end, NewSet, lists:seq(0, I-1)),
        lists:foldl(fun(V, {MinDiffAcc, ResultAcc}) ->
            Diff = abs(V - K),
            if
                Diff < MinDiffAcc ->
                    {Diff, V};
                true ->
                    {MinDiffAcc, ResultAcc}
            end
        end, {MinDiff, Result}, FoldResult)
    end, {MinDiff, Result}, lists:seq(0, N-1)),
    Result.