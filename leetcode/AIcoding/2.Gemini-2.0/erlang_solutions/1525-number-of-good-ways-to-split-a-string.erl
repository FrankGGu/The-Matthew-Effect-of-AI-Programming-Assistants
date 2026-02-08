-module(good_ways_to_split).
-export([num_splits/1]).

num_splits(S) ->
  num_splits(S, [], []).

num_splits([], LeftSet, RightSet) ->
  0.

num_splits([H|T], LeftSet, RightSet) ->
  case num_splits(T, lists:union(LeftSet, [H]), lists:subtract(RightSet, [H])) of
    N when lists:length(lists:union(LeftSet, [H])) == lists:length(lists:subtract(RightSet, [H])) ->
      1 + N;
    N ->
      N
  end.

num_splits(S, LeftSet, []) ->
  num_splits(S, LeftSet, lists:usort(S)).