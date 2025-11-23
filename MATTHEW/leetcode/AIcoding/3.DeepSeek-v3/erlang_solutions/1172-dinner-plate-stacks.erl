-module(dinner_plates).
-export([init/1, push/2, pop/1, popAtStack/2]).

-record(state, {
    capacity :: integer(),
    stacks = [] :: [list()],
    left = 0 :: integer(),
    right = 0 :: integer(),
    available = gb_sets:new() :: gb_sets:set(integer())
}).

init(Capacity) ->
    #state{capacity = Capacity}.

push(Val, State = #state{capacity = C, stacks = Stacks, left = Left, available = Avail}) ->
    case gb_sets:is_empty(Avail) of
        true ->
            NewStacks = case Left >= length(Stacks) of
                true -> Stacks ++ [[]];
                false -> Stacks
            end,
            [Stack | Rest] = lists:nthtail(Left, NewStacks),
            case length(Stack) < C of
                true ->
                    NewStack = [Val | Stack],
                    UpdatedStacks = lists:sublist(NewStacks, Left) ++ [NewStack] ++ Rest,
                    NewLeft = case length(NewStack) < C of
                        true -> Left;
                        false -> Left + 1
                    end,
                    State#state{stacks = UpdatedStacks, left = NewLeft};
                false ->
                    NewStack = [Val],
                    UpdatedStacks = lists:sublist(NewStacks, Left + 1) ++ [NewStack] ++ Rest,
                    State#state{stacks = UpdatedStacks, left = Left + 1}
            end;
        false ->
            {Index, NewAvail} = gb_sets:take_smallest(Avail),
            [Stack | Rest] = lists:nthtail(Index, Stacks),
            NewStack = [Val | Stack],
            UpdatedStacks = lists:sublist(Stacks, Index) ++ [NewStack] ++ Rest,
            case length(NewStack) < C of
                true -> State#state{stacks = UpdatedStacks, available = gb_sets:add_element(Index, NewAvail)};
                false -> State#state{stacks = UpdatedStacks, available = NewAvail}
            end
    end.

pop(State = #state{stacks = Stacks, right = Right, available = Avail}) ->
    case Stacks of
        [] -> {-1, State};
        _ ->
            case Right > 0 of
                true ->
                    [Stack | Rest] = lists:nthtail(Right - 1, Stacks),
                    case Stack of
                        [] ->
                            NewState = State#state{right = Right - 1},
                            pop(NewState);
                        [Val | NewStack] ->
                            UpdatedStacks = lists:sublist(Stacks, Right - 1) ++ [NewStack] ++ Rest,
                            NewAvail = gb_sets:add_element(Right - 1, Avail),
                            {Val, State#state{stacks = UpdatedStacks, available = NewAvail}}
                    end;
                false -> {-1, State}
            end
    end.

popAtStack(Index, State = #state{stacks = Stacks, available = Avail}) ->
    case Index < length(Stacks) of
        true ->
            [Stack | Rest] = lists:nthtail(Index, Stacks),
            case Stack of
                [] -> {-1, State};
                [Val | NewStack] ->
                    UpdatedStacks = lists:sublist(Stacks, Index) ++ [NewStack] ++ Rest,
                    NewAvail = gb_sets:add_element(Index, Avail),
                    {Val, State#state{stacks = UpdatedStacks, available = NewAvail}}
            end;
        false -> {-1, State}
    end.