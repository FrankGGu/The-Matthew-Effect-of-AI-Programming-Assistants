-module(dinner_plate_stacks).
-export([new/1, push/2, pop/1, pop_at_stack/2]).

-record(state, {stacks = [], capacity}).

new(Capacity) ->
    #state{stacks = [], capacity = Capacity}.

push(Value, State) ->
    push_helper(Value, State#state.stacks, State#state.capacity, State).

push_helper(Value, [], Capacity, State) ->
    #state{stacks = [[Value]], capacity = Capacity}.
push_helper(Value, [Stack | Rest], Capacity, State) ->
    case length(Stack) < Capacity of
        true ->
            #state{stacks = [[Value | Stack] | Rest], capacity = Capacity};
        false ->
            push_helper(Value, Rest, Capacity, State)
    end.

pop(State) ->
    pop_helper(State#state.stacks, State).

pop_helper([], State) ->
    -1;
pop_helper([[] | Rest], State) ->
    pop_helper(Rest, State);
pop_helper([Stack | Rest], State) ->
    case Stack of
        [] ->
            pop_helper(Rest, State);
        [Top | Tail] ->
            {Top, #state{stacks = [Tail | Rest], capacity = State#state.capacity}}
    end.

pop_at_stack(Index, State) ->
    pop_at_stack_helper(Index, State#state.stacks, 0, State).

pop_at_stack_helper(_Index, [], _Count, State) ->
    -1;
pop_at_stack_helper(Index, [Stack | Rest], Count, State) ->
    case Index =:= Count of
        true ->
            case Stack of
                [] ->
                    -1;
                [Top | Tail] ->
                    {Top, #state{stacks = [Tail | Rest], capacity = State#state.capacity}}
            end;
        false ->
            pop_at_stack_helper(Index, Rest, Count + 1, State)
    end.