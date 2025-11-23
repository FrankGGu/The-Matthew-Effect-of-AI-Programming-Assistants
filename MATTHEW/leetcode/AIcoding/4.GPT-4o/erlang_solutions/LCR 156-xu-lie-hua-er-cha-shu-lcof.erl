-module(solution).
-export([serialize/1, deserialize/1]).

-type tree() :: 'nil' | {value, tree(), tree()}.

serialize(Tree) ->
    serialize_helper(Tree, []).

serialize_helper('nil', Acc) ->
    Acc ++ ["#"];
serialize_helper({Value, Left, Right}, Acc) ->
    serialize_helper(Right, serialize_helper(Left, Acc ++ [Value])).

deserialize(Data) ->
    deserialize_helper(Data, []).

deserialize_helper([], Acc) ->
    {lists:reverse(Acc), []};
deserialize_helper(["#" | Rest], Acc) ->
    {lists:reverse(Acc), Rest};
deserialize_helper([Value | Rest], Acc) ->
    {Left, Remaining} = deserialize_helper(Remaining, Acc),
    {Right, Remaining2} = deserialize_helper(Remaining, []),
    {{Value, Left, Right}, Remaining2}.