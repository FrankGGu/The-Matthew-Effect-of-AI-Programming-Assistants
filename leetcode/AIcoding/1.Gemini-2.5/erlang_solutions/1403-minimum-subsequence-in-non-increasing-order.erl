-module(solution).
-export([min_subsequence/1]).

min_subsequence(Nums) ->
    TotalSum = lists:sum(Nums),
    SortedNums = lists:reverse(lists:sort(Nums)),
    find_subsequence(SortedNums, TotalSum, 0, []).

find_subsequence([H | T], TotalSum, CurrentSubsequenceSum, AccSubsequence) ->
    NewCurrentSubsequenceSum = CurrentSubsequenceSum + H,
    NewAccSubsequence = [H | AccSubsequence],
    RemainingSum = TotalSum - NewCurrentSubsequenceSum,
    if
        NewCurrentSubsequenceSum > RemainingSum ->
            lists:reverse(NewAccSubsequence);
        true ->
            find_subsequence(T, TotalSum, NewCurrentSubsequenceSum, NewAccSubsequence)
    end.