-module(solution).
-export([getLeastNumbers/2]).

getLeastNumbers(Arr, K) ->
    SortedArr = lists:sort(Arr),
    lists:sublist(SortedArr, K).