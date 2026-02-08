-module(delete_middle_node).
-export([delete_middle_node/1]).

-spec delete_middle_node([integer()]) -> [integer()].
delete_middle_node([]) ->
  [];
delete_middle_node(List) ->
  Len = length(List),
  MiddleIndex = div(Len, 2),
  lists:delete_at(List, MiddleIndex + 1).