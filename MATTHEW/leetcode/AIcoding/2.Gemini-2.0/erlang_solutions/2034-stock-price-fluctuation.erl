-module(stock_price).
-export([new/0, update/2, current/1, maximum/1, minimum/1]).

-record(state, {
    prices = dict:new(),
    max_timestamp = 0,
    max_heap = gb_trees:empty(),
    min_heap = gb_trees:empty()
}).

new() ->
    #state{}.

update(State, Timestamp, Price) ->
    NewState = State#state{
        prices = dict:store(Timestamp, Price, State#state.prices),
        max_timestamp = max(Timestamp, State#state.max_timestamp),
        max_heap = gb_trees:insert({Price, Timestamp}, true, State#state.max_heap),
        min_heap = gb_trees:insert({Price, Timestamp}, true, State#state.min_heap)
    };
    NewState.

current(State) ->
    dict:fetch(State#state.max_timestamp, State#state.prices).

maximum(State) ->
    maximum_helper(State#state.max_heap, State#state.prices).

minimum(State) ->
    minimum_helper(State#state.min_heap, State#state.prices).

maximum_helper(Heap, Prices) ->
    case gb_trees:largest(Heap) of
        none ->
            error(empty);
        {Key, _} ->
            {Price, Timestamp} = Key;
            case dict:fetch(Timestamp, Prices) of
                Price ->
                    Price;
                _ ->
                    NewHeap = gb_trees:delete(Key, Heap);
                    maximum_helper(NewHeap, Prices)
            end
    end.

minimum_helper(Heap, Prices) ->
    case gb_trees:smallest(Heap) of
        none ->
            error(empty);
        {Key, _} ->
            {Price, Timestamp} = Key;
            case dict:fetch(Timestamp, Prices) of
                Price ->
                    Price;
                _ ->
                    NewHeap = gb_trees:delete(Key, Heap);
                    minimum_helper(NewHeap, Prices)
            end
    end.