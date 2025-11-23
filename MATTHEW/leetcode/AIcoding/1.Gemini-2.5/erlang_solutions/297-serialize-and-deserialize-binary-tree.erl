-module(solution).
-export([serialize/1, deserialize/1]).

-record('TreeNode', {val, left, right}).

serialize(nil) ->
    "N";
serialize(#'TreeNode'{val=Val, left=Left, right=Right}) ->
    io_lib:format("~p,~s,~s", [Val, serialize(Left), serialize(Right)]).

deserialize(DataString) ->
    Tokens = string:split(DataString, ",", [trim]),
    {Tree, _} = deserialize_helper(Tokens).

deserialize_helper(["N"|T]) ->
    {nil, T};
deserialize_helper([H|T]) ->
    Val = list_to_integer(H),
    {Left, T1} = deserialize_helper(T),
    {Right, T2} = deserialize_helper(T1),
    {#'TreeNode'{val=Val, left=Left, right=Right}, T2}.