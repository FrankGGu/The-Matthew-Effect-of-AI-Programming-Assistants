-module(reduce_array_size).
-export([min_set_size/1]).

min_set_size(Arr) ->
  N = length(Arr),
  Counts = lists:foldl(fun(X, Acc) ->
                             maps:update_with(X, fun(V) -> V + 1 end, 1, Acc)
                         end, #{}, Arr),
  Values = maps:values(Counts),
  SortedValues = lists:sort(fun(A, B) -> B < A end, Values),
  min_set_size_helper(SortedValues, N, 0, 0).

min_set_size_helper([], _, Count, Size) ->
  Count;
min_set_size_helper([H | T], N, Count, Size) ->
  if Size >= N div 2 then
    Count
  else
    min_set_size_helper(T, N, Count + 1, Size + H)
  end.