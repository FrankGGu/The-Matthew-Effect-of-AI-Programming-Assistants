-module(smallestInfiniteSet).
-export([new/0, popSmallest/1, addBack/2]).

-record(state, {removed = sets:new(), added = []}).

new() ->
    #state{}.

popSmallest(State) ->
    case State#state.added of
        [] ->
            Removed = State#state.removed,
            Smallest = case sets:is_empty(Removed) of
                true -> 1;
                false ->
                    case sets:smallest(Removed) of
                        1 -> 
                            case sets:is_element(1, Removed) of
                                true ->  find_smallest_greater_than(1, Removed);
                                false -> 1
                            end;
                        SmallestVal -> 1
                    end
            end,
            NewRemoved = sets:add_element(Smallest, sets:del_element(Smallest, Removed)),
            {Smallest, State#state{removed = NewRemoved}};
        _ ->
            SortedAdded = lists:sort(State#state.added),
            Smallest = lists:nth(1, SortedAdded),
            NewAdded = lists:delete(Smallest, State#state.added),
            {Smallest, State#state{added = NewAdded}}
    end.

addBack(Num, State) ->
    Removed = State#state.removed,
    case lists:member(Num, State#state.added) of
        true -> State;
        false ->
            case sets:is_element(Num, Removed) of
                true ->
                     NewRemoved = sets:del_element(Num, Removed),
                     State#state{removed = NewRemoved};
                false -> State
            end
    end.

find_smallest_greater_than(N, Set) ->
    case sets:is_element(N+1, Set) of
        true -> find_smallest_greater_than(N+1, Set);
        false -> N+1
    end.