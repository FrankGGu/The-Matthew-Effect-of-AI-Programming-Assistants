-module(solution).
-export([findMaxAverage/2]).

findMaxAverage(Nums, K) ->
    InitialWindow = lists:sublist(Nums, K),
    InitialSum = lists:sum(InitialWindow),

    Removers = Nums,
    Adders = lists:nthtail(K, Nums),

    MaxSum = slide_window(Removers, Adders, InitialSum, InitialSum),

    MaxSum / K.

slide_window(_, [], _CurrentSum, MaxSum) ->
    MaxSum;
slide_window([Remove | RestRemovers], [Add | RestAdders], CurrentSum, MaxSum) ->
    NewCurrentSum = CurrentSum - Remove + Add,
    NewMaxSum = max(MaxSum, NewCurrentSum),
    slide_window(RestRemovers, RestAdders, NewCurrentSum, NewMaxSum).