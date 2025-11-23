-module(solution).

-export([serialize/1, deserialize/1]).

-record(node, {val, left = undefined, right = undefined}).

serialize(Tree) ->
    serialize(Tree, []).

serialize(undefined, Acc) ->
    Acc ++ ["#"];
serialize(#node{val=Val, left=Left, right=Right}, Acc) ->
    serialize(Left, Acc ++ [integer_to_list(Val)]) ++ serialize(Right, Acc).

deserialize(Str) ->
    {Tree, _} = deserialize(Str, 0),
    Tree.

deserialize(Str, Index) ->
    case lists:nth(Index + 1, Str) of
        "#" ->
            {undefined, Index + 1};
        Val ->
            NewIndex = Index + 1,
            {#node{val=list_to_integer(Val)}, LeftIndex} = deserialize(Str, NewIndex),
            {Node#node{left=Left}, RightIndex} = deserialize(Str, LeftIndex),
            {Node#node{right=Right}, RightIndex}
    end.