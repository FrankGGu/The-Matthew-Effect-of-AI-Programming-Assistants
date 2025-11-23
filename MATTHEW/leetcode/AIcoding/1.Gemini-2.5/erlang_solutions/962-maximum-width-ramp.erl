-module(solution).
-export([maxWidthRamp/1]).

maxWidthRamp(A) ->
    N = length(A),
    if N < 2 -> 0;
       true ->
            IndexedA = lists:zip(A, lists:seq(0, N - 1)),
            SortedIndexedA = lists:sort(IndexedA),

            case SortedIndexedA of
                [] -> 0;
                [{_Val1, Idx1} | RestOfSorted] ->
                    {FinalMaxWidth, _FinalMinIdx} =
                        lists:foldl(fun({_CurrentVal, CurrentIdx}, {AccMax, AccMinIdx}) ->
                                            NewMax = max(AccMax, CurrentIdx - AccMinIdx),
                                            NewMinIdx = min(AccMinIdx, CurrentIdx),
                                            {NewMax, NewMinIdx}
                                    end, {0, Idx1}, RestOfSorted),
                    FinalMaxWidth
            end
    end.