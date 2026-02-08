-module(stock_price).

-export([init/0, update/3, current/1, maximum/1, minimum/1]).

-record(state, {
    current_time = undefined,
    prices = #{},
    max_heap = gb_sets:new(),
    min_heap = gb_sets:new(),
    count = #{}
}).

init() ->
    #state{}.

update(State, Timestamp, Price) ->
    OldPrice = maps:get(Timestamp, State#state.prices, undefined),
    NewPrices = maps:put(Timestamp, Price, State#state.prices),
    NewCount = case OldPrice of
        undefined ->
            State#state.count;
        _ ->
            maps:update_with(OldPrice, fun(C) -> C - 1 end, State#state.count)
    end,
    NewCount2 = maps:update_with(Price, fun(C) -> C + 1 end, 1, NewCount),
    MaxHeap = case OldPrice of
        undefined ->
            gb_sets:add_element(Price, State#state.max_heap);
        _ ->
            case maps:get(OldPrice, NewCount2, 0) of
                0 ->
                    gb_sets:del_element(OldPrice, State#state.max_heap);
                _ ->
                    State#state.max_heap
            end
    end,
    MaxHeap2 = gb_sets:add_element(Price, MaxHeap),
    MinHeap = case OldPrice of
        undefined ->
            gb_sets:add_element(Price, State#state.min_heap);
        _ ->
            case maps:get(OldPrice, NewCount2, 0) of
                0 ->
                    gb_sets:del_element(OldPrice, State#state.min_heap);
                _ ->
                    State#state.min_heap
            end
    end,
    MinHeap2 = gb_sets:add_element(Price, MinHeap),
    NewState = State#state{
        current_time = max(Timestamp, State#state.current_time),
        prices = NewPrices,
        max_heap = MaxHeap2,
        min_heap = MinHeap2,
        count = NewCount2
    },
    NewState.

current(State) ->
    maps:get(State#state.current_time, State#state.prices).

maximum(State) ->
    gb_sets:largest(State#state.max_heap).

minimum(State) ->
    gb_sets:smallest(State#state.min_heap).