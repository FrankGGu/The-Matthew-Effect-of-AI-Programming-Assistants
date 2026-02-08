-module(relative_sort_array).
-export([relative_sort_array/2]).

relative_sort_array(Arr1, Arr2) ->
  {Common, Remaining} = lists:partition(fun(X) -> lists:member(X, Arr2) end, Arr1),
  SortedCommon = lists:sort(fun(A, B) ->
                                 IndexA = lists:keyfind(A, 1, lists:zip(Arr2, lists:seq(1, length(Arr2)))),
                                 IndexB = lists:keyfind(B, 1, lists:zip(Arr2, lists:seq(1, length(Arr2)))),
                                 case {IndexA, IndexB} of
                                   {false, false} -> A < B;
                                   {false, _} -> false;
                                   {_, false} -> true;
                                   {_, _} -> element(2, IndexA) < element(2, IndexB)
                                 end
                               end, Common),
  SortedRemaining = lists:sort(Remaining),
  SortedCommon ++ SortedRemaining.