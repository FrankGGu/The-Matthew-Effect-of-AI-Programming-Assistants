-module(max_nesting_depth).
-export([max_depth_after_split/1]).

max_depth_after_split(S) ->
  max_depth_after_split(S, 0, 0, [], []).

max_depth_after_split([], _, _, A, B) ->
  [A, B];
max_depth_after_split([H|T], Da, Db, A, B) ->
  case H of
    $( ->
      if Da < Db then
        max_depth_after_split(T, Da + 1, Db, [0|A], B)
      else
        max_depth_after_split(T, Da, Db + 1, A, [1|B])
      end;
    $) ->
      if Da > Db then
        max_depth_after_split(T, Da - 1, Db, [0|A], B)
      else
        max_depth_after_split(T, Da, Db - 1, A, [1|B])
      end
  end.