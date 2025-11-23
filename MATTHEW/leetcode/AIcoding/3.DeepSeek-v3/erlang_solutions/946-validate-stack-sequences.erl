-spec validate_stack_sequences(Pushed :: [integer()], Popped :: [integer()]) -> boolean().
validate_stack_sequences(Pushed, Popped) ->
    validate_stack_sequences(Pushed, Popped, [], 0).

validate_stack_sequences(_, [], Stack, _) ->
    Stack == [];
validate_stack_sequences([], [PopH | PopT], [StackH | StackT], _) when PopH == StackH ->
    validate_stack_sequences([], PopT, StackT, 0);
validate_stack_sequences([], _, _, _) ->
    false;
validate_stack_sequences([PushH | PushT], [PopH | _] = Popped, Stack, _) when PushH == PopH ->
    validate_stack_sequences(PushT, tl(Popped), Stack, 0);
validate_stack_sequences([PushH | PushT], Popped, Stack, _) ->
    validate_stack_sequences(PushT, Popped, [PushH | Stack], 0).