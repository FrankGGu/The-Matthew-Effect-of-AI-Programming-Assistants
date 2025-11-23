-module(solution).
-export([serialize/1, deserialize/1]).

-record('TreeNode', {val, left = nil, right = nil}).

serialize(Root) ->
    List = serialize_to_list(Root),
    string:join(List, ",").

serialize_to_list(nil) ->
    ["N"];
serialize_to_list(#'TreeNode'{val = Val, left = Left, right = Right}) ->
    [integer_to_list(Val)] ++ serialize_to_list(Left) ++ serialize_to_list(Right).

deserialize(Data) ->
    Tokens = string:split(Data, ",", all),
    {Tree, _RemainingTokens} = deserialize_helper(Tokens).

deserialize_helper(["N" | Rest]) ->
    {nil, Rest};
deserialize_helper([ValStr | Rest]) ->
    Val = list_to_integer(ValStr),
    {Left, Rest1} = deserialize_helper(Rest),
    {Right, Rest2} = deserialize_helper(Rest1),
    {#'TreeNode'{val = Val, left = Left, right = Right}, Rest2}.