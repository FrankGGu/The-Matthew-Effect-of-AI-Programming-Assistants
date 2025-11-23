-module(codec).
-export([serialize/1, deserialize/1]).

-type tree_node() :: {integer(), tree_node(), tree_node()} | null.

serialize(null) -> "null,";
serialize({Val, Left, Right}) ->
  integer_to_list(Val) ++ "," ++ serialize(Left) ++ serialize(Right).

deserialize(Data) ->
  deserialize_helper(string:tokens(Data, ",")).

deserialize_helper(["null" | Rest]) ->
  {null, Rest};
deserialize_helper([Value | Rest]) ->
  {Val, _} = string:to_integer(Value),
  {Left, Rest1} = deserialize_helper(Rest),
  {Right, Rest2} = deserialize_helper(Rest1),
  {{Val, Left, Right}, Rest2}.