-module(verify_preorder).
-export([is_valid_serialization/1]).

is_valid_serialization(Preorder) ->
    Nodes = string:tokens(Preorder, ","),
    stack_size(Nodes, 1).

stack_size([], Stack) ->
    Stack == 0;
stack_size([Node | Rest], Stack) when Stack > 0 ->
    case Node of
        "#" ->
            stack_size(Rest, Stack - 1);
        _ ->
            stack_size(Rest, Stack + 1)
    end;
stack_size(_, _) ->
    false.