-module(relative_sort_array).
-export([relative_sort_array/2]).

relative_sort_array(Arr1, Arr2) ->
  relative_sort_array(Arr1, Arr2, []).

relative_sort_array(Arr1, [], Acc) ->
  lists:sort(Acc ++ Arr1);
relative_sort_array(Arr1, [H | T], Acc) ->
  {Has, Remain} = lists:partition(fun(X) -> X == H end, Arr1),
  relative_sort_array(Remain, T, Acc ++ Has).