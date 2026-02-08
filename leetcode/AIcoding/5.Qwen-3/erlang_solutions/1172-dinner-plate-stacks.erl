-module(dinner_plate_stacks).
-export([new/1, push/2, pop/1, pop_at/2, peek/1, peek_at/2]).

-record(state, {capacity, stacks, leftmost}).

new(Capacity) ->
    #state{capacity = Capacity, stacks = [], leftmost = 0}.

push(State, Val) ->
    #state{capacity = Cap, stacks = Stacks, leftmost = Leftmost} = State,
    case lists:keymember(Leftmost, 1, Stacks) of
        true ->
            [Stack | Rest] = lists:keyreplace(Leftmost, 1, {Leftmost, [Val | element(2, lists:keyfind(Leftmost, 1, Stacks))]}, Stacks),
            NewState = #state{capacity = Cap, stacks = [Stack | Rest], leftmost = Leftmost},
            NewState;
        false ->
            NewStacks = [{Leftmost, [Val]} | Stacks],
            NewState = #state{capacity = Cap, stacks = NewStacks, leftmost = Leftmost + 1},
            NewState
    end.

pop(State) ->
    #state{capacity = Cap, stacks = Stacks, leftmost = Leftmost} = State,
    case Stacks of
        [] -> {error, empty};
        _ ->
            {Index, Stack} = lists:last(Stacks),
            case Stack of
                [] -> pop(State);
                [Val | Rest] ->
                    NewStacks = lists:sublist(Stacks, length(Stacks) - 1),
                    NewState = #state{capacity = Cap, stacks = NewStacks, leftmost = Leftmost},
                    {ok, Val, NewState}
            end
    end.

pop_at(State, Index) ->
    #state{capacity = Cap, stacks = Stacks, leftmost = Leftmost} = State,
    case lists:keyfind(Index, 1, Stacks) of
        false -> {error, invalid_index};
        {Index, Stack} ->
            case Stack of
                [] -> {error, empty};
                [Val | Rest] ->
                    NewStacks = lists:keyreplace(Index, 1, {Index, Rest}, Stacks),
                    NewState = #state{capacity = Cap, stacks = NewStacks, leftmost = Leftmost},
                    {ok, Val, NewState}
            end
    end.

peek(State) ->
    #state{stacks = Stacks} = State,
    case Stacks of
        [] -> {error, empty};
        _ ->
            {Index, Stack} = lists:last(Stacks),
            case Stack of
                [] -> peek(State);
                [Val | _] -> {ok, Val}
            end
    end.

peek_at(State, Index) ->
    #state{stacks = Stacks} = State,
    case lists:keyfind(Index, 1, Stacks) of
        false -> {error, invalid_index};
        {Index, Stack} ->
            case Stack of
                [] -> {error, empty};
                [Val | _] -> {ok, Val}
            end
    end.