-module(solution).
-export([maximumElementAfterDecrementingAndRearranging/1]).

maximumElementAfterDecrementingAndRearranging(Arr) ->
    SortedArr = lists:sort(Arr),
    lists:foldl(fun(X, Acc) ->
                        if X > Acc ->
                                Acc + 1;
                           true ->
                                Acc
                        end
                end, 0, SortedArr).