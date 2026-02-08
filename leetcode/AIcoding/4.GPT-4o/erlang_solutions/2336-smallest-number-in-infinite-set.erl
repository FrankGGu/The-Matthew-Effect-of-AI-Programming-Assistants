-module(SmallestInfiniteSet).
-export([new/0, popSmallest/1, addBack/2]).

-record(state, {set = sets:new(), next = 1}).

new() ->
    #state{}.

popSmallest(State) ->
    case sets:is_empty(State#set) of
        true ->
            {Smallest, NewNext} = {State#next, State#next + 1},
            {Smallest, State#state{next = NewNext}};
        false ->
            {Smallest, NewSet} = sets:smallest(State#set),
            {Smallest, NewState} = {Smallest, State#state{set = sets:remove(Smallest, State#set)}},
            {Smallest, NewState}
    end.

addBack(State, num) ->
    if
        num < State#next, 
        not sets:is_element(num, State#set) ->
            NewSet = sets:add_element(num, State#set),
            State#state{set = NewSet};
        true -> 
            State
    end.