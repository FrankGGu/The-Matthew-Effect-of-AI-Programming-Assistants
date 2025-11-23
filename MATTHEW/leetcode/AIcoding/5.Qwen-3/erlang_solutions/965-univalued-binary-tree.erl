-module(univalued_binary_tree).
-export([is_univalued/1]).

-include_lib("eunit/include/eunit.hrl").

is_univalued(nil) -> true;
is_univalued(#{} = Node) ->
    Value = maps:get(value, Node),
    Left = maps:get(left, Node, nil),
    Right = maps:get(right, Node, nil),
    is_univalued(Value, Left) andalso is_univalued(Value, Right).

is_univalued(_, nil) -> true;
is_univalued(Value, #{} = Node) ->
    maps:get(value, Node) == Value andalso
        is_univalued(Value, maps:get(left, Node, nil)) andalso
        is_univalued(Value, maps:get(right, Node, nil)).