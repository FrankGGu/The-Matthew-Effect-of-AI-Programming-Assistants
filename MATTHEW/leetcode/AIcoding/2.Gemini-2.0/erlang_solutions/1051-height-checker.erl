-module(height_checker).
-export([height_checker/1]).

height_checker(Heights) ->
  SortedHeights = lists:sort(Heights),
  count_differences(Heights, SortedHeights, 0).

count_differences([], [], Count) ->
  Count;
count_differences([H | RestH], [S | RestS], Count) ->
  case H =:= S of
    true ->
      count_differences(RestH, RestS, Count);
    false ->
      count_differences(RestH, RestS, Count + 1)
  end.