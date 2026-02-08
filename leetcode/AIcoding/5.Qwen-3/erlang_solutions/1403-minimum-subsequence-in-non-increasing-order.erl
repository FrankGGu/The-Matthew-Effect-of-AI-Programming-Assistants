-module(minimum_subsequence).
-export([min_subsequence/1]).

min_subsequence(Nums) ->
    Sorted = lists:reverse(lists:sort(Nums)),
    Sum = lists:sum(Sorted),
    min_subsequence(Sorted, 0, [], Sum).

min_subsequence([], _, Result, _) ->
    Result;
min_subsequence([H | T], CurrentSum, Result, Total) ->
    NewSum = CurrentSum + H,
    NewResult = [H | Result],
    if
        NewSum > Total - NewSum ->
            NewResult;
        true ->
            min_subsequence(T, NewSum, NewResult, Total)
    end.