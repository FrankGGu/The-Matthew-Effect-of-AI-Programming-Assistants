-module(solution).
-export([shuffle/1, reset/1]).

-record(state, {original, shuffled}).

shuffle(State) ->
    Shuffled = shuffle_list(State#state.shuffled),
    State#state{shuffled = Shuffled}.

reset(State) ->
    State#state{shuffled = State#state.original}.

shuffle_list([]) ->
    [];
shuffle_list(List) ->
    {Elem, Rest} = random_element(List),
    [Elem | shuffle_list(Rest)].

random_element(List) ->
    Len = length(List),
    Index = rand:uniform(Len) - 1,
    {lists:nth(Index + 1, List), lists:delete(lists:nth(Index + 1, List), List)}.