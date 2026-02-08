-module(combination_iterator).
-export([init/1, next/1, has_next/1]).

-record(state, {
    characters :: list(),
    length :: integer(),
    indices :: list(),
    has_next :: boolean()
}).

init(Characters, CombinationLength) ->
    Sorted = lists:sort(Characters),
    Indices = lists:seq(0, CombinationLength - 1),
    State = #state{
        characters = Sorted,
        length = CombinationLength,
        indices = Indices,
        has_next = true
    },
    State.

next(State) ->
    #state{
        characters = Chars,
        length = Len,
        indices = Indices,
        has_next = HasNext
    } = State,
    Result = [lists:nth(I + 1, Chars) || I <- Indices],
    NewIndices = next_indices(Indices, length(Chars), Len),
    NewHasNext = NewIndices =/= none,
    NewState = State#state{
        indices = if NewHasNext -> NewIndices; true -> Indices end,
        has_next = NewHasNext
    },
    {Result, NewState}.

has_next(#state{has_next = HasNext}) ->
    HasNext.

next_indices(Indices, Max, Len) ->
    next_indices(Indices, Max, Len, Len - 1).

next_indices(Indices, Max, Len, Pos) when Pos >= 0 ->
    Current = lists:nth(Pos + 1, Indices),
    if
        Current < Max - Len + Pos ->
            NewCurrent = Current + 1,
            NewIndices = lists:sublist(Indices, Pos) ++ [NewCurrent] ++ lists:seq(NewCurrent + 1, NewCurrent + Len - Pos - 1),
            NewIndices;
        true ->
            next_indices(Indices, Max, Len, Pos - 1)
    end;
next_indices(_, _, _, _) ->
    none.