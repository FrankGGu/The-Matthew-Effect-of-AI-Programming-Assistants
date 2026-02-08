%% Define a record for the stack
-record(min_stack, {stack = [], min_stack = []}).

-spec min_stack_init() -> #min_stack{}.
min_stack_init() -> 
    #min_stack{stack = [], min_stack = []}.

-spec min_stack_push(#min_stack{}, integer()) -> #min_stack{}.
min_stack_push(#min_stack{stack = Stack, min_stack = MinStack} = State, Val) -> 
    NewMinStack = 
        case MinStack of
            [] -> [Val];
            [Min | _] when Val < Min -> [Val];
            _ -> MinStack
        end,
    #min_stack{stack = [Val | Stack], min_stack = NewMinStack}.

-spec min_stack_pop(#min_stack{}) -> #min_stack{}.
min_stack_pop(#min_stack{stack = [Top | Rest], min_stack = [Min | MinRest]}) ->
    #min_stack{stack = Rest, min_stack = MinRest};
min_stack_pop(State) -> State.

-spec min_stack_top(#min_stack{}) -> integer().
min_stack_top(#min_stack{stack = [Top | _]}) -> Top;
min_stack_top(_) -> 0.

-spec min_stack_get_min(#min_stack{}) -> integer().
min_stack_get_min(#min_stack{min_stack = [Min | _]}) -> Min;
min_stack_get_min(_) -> 0.
