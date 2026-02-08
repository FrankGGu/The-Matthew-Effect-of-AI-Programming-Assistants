-module(solution).
-export([kth_missing_positive/2]).

kth_missing_positive(Arr, K) ->
    find_kth(1, Arr, K, 0).

find_kth(CurrentNum, _ArrList, K, CurrentMissingCount) when CurrentMissingCount == K ->
    CurrentNum - 1;
find_kth(CurrentNum, [], K, CurrentMissingCount) ->
    CurrentNum + (K - CurrentMissingCount) - 1;
find_kth(CurrentNum, [H|T], K, CurrentMissingCount) when CurrentNum == H ->
    find_kth(CurrentNum + 1, T, K, CurrentMissingCount);
find_kth(CurrentNum, [H|T], K, CurrentMissingCount) when CurrentNum < H ->
    find_kth(CurrentNum + 1, [H|T], K, CurrentMissingCount + 1).