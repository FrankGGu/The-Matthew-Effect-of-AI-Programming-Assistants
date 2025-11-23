-module(nested_iterator).
-export([init/1, has_next/1, next/1]).

init(NestedList) ->
    NestedList.

has_next(Stack) ->
    case Stack of
        [] -> {false, []};
        [H|T] when is_integer(H) -> {true, Stack};
        [H|T] when is_list(H) ->
            %% If the head is a list, flatten it by pushing its elements
            %% onto the stack in reverse order. This ensures the first element
            %% of the sublist is processed first.
            NewStack = lists:reverse(H) ++ T,
            has_next(NewStack) % Recursively call to continue flattening
    end.

next(Stack) ->
    [Value|NewStack] = Stack,
    {Value, NewStack}.