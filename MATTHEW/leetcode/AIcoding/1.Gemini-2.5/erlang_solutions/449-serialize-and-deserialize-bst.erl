-module(codec).
-export([serialize/1, deserialize/1]).

serialize(nil) ->
    "";
serialize({node, Val, Left, Right}) ->
    Values = serialize_to_list({node, Val, Left, Right}),
    string:join([integer_to_list(X) || X <- Values], " ").

serialize_to_list(nil) ->
    [];
serialize_to_list({node, Val, Left, Right}) ->
    [Val | serialize_to_list(Left) ++ serialize_to_list(Right)].

deserialize("") ->
    nil;
deserialize(Data) ->
    Tokens = string:tokens(Data, " "),
    Ints = [list_to_integer(T) || T <- Tokens],
    {Tree, _Remaining} = deserialize_helper(Ints, -2147483648, 2147483647),
    Tree.

deserialize_helper([], _Min, _Max) ->
    {nil, []};
deserialize_helper([Head|Tail], Min, Max) ->
    case Head of
        _ when Head < Min; Head > Max ->
            {nil, [Head|Tail]};
        Val ->
            {LeftChild, Remaining1} = deserialize_helper(Tail, Min, Val - 1),
            {RightChild, Remaining2} = deserialize_helper(Remaining1, Val + 1, Max),
            {{node, Val, LeftChild, RightChild}, Remaining2}
    end.