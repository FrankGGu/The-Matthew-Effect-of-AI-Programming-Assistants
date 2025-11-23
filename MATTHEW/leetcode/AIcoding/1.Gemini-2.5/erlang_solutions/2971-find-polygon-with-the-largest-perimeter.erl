-module(solution).
-export([largestPerimeter/1]).

largestPerimeter(Nums) ->
    SortedNums = lists:sort(Nums),
    InitialSum = lists:sum(SortedNums),
    find_largest_perimeter(lists:reverse(SortedNums), InitialSum).

find_largest_perimeter([_A, _B, _C | _Rest] = List, CurrentSum) ->
    [LongestSide | Rest] = List,
    SumOfOthers = CurrentSum - LongestSide,
    if
        SumOfOthers > LongestSide ->
            CurrentSum;
        true ->
            find_largest_perimeter(Rest, SumOfOthers)
    end;
find_largest_perimeter(_List, _CurrentSum) ->
    -1.