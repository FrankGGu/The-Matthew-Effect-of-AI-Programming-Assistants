-module(solution).
-export([solution_serialize/1, solution_deserialize/1]).

% Define the structure of the TreeNode (for internal use).
-record(tree_node, {val, left, right}).

%% Serializes the binary search tree into a string.
-spec solution_serialize(any()) -> string().
solution_serialize(nil) -> "".
solution_serialize(#tree_node{val=Val, left=Left, right=Right}) ->
    lists:flatten(io_lib:format("~p,~p,~p", [Val, solution_serialize(Left), solution_serialize(Right)])).

%% Deserializes the string back into the binary search tree.
-spec solution_deserialize(string()) -> any().
solution_deserialize("") -> nil;
solution_deserialize(Data) ->
    {Tree, _} = deserialize_helper(string:tokens(Data, ","), nil),
    Tree.

%% Helper function to process the tokenized string and construct the tree.
deserialize_helper([ValStr | Rest], Parent) ->
    case string:to_integer(ValStr) of
        {ok, Val} -> 
            NewNode = #tree_node{val = Val, left = nil, right = nil},
            {NewNode, Rest};
        _ -> 
            {nil, Rest}
    end.
deserialize_helper([], _) -> {nil, []}.

%% Example usage for testing:

%% Test serialization
%% Test deserialization
