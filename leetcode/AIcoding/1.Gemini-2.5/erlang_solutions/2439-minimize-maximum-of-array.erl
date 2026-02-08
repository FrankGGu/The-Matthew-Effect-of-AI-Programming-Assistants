-module(solution).
-export([minimizeArrayValue/1]).

minimizeArrayValue(Nums) ->
    Low = 0,
    High = lists:max(Nums),
    BinarySearch(Low, High, High, Nums).

BinarySearch(Low, High, Ans, Nums) ->
    if
        Low > High -> Ans;
        true ->
            Mid = Low + (High - Low) div 2,
            case check(Mid, Nums) of
                true ->
                    % Mid is a possible answer, try to find a smaller one
                    BinarySearch(Low, Mid - 1, Mid, Nums);
                false ->
                    % Mid is too small, need a larger value
                    BinarySearch(Mid + 1, High, Ans, Nums)
            end
    end.

check(X, Nums) ->
    check_prefix_average(X, Nums, 0, 0).

check_prefix_average(_X, [], _CurrentSum, _Index) ->
    true;
check_prefix_average(X, [H|T], CurrentSum, Index) ->
    NewCurrentSum = CurrentSum + H,
    NewIndex = Index + 1,
    if
        NewCurrentSum > X * NewIndex ->
            false;
        true ->
            check_prefix_average(X, T, NewCurrentSum, NewIndex)
    end.