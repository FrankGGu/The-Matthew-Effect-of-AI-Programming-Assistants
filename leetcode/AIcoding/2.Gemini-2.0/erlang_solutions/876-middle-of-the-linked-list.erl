-module(middle_linked_list).
-export([middleNode/1]).

-spec middleNode(list()) -> list().
middleNode(List) ->
  middleNodeHelper(List, List).

middleNodeHelper([], _) ->
  [];
middleNodeHelper([_], Slow) ->
  Slow;
middleNodeHelper([_, _ | Rest], [SlowHead | SlowRest]) ->
  middleNodeHelper(Rest, SlowRest);
middleNodeHelper(_, Slow) ->
  Slow.