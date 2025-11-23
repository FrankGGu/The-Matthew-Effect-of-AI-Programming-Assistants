-module(lru_cache).
-export([new/1, get/2, put/3]).

-record(state, {
    capacity :: integer(),
    data_table :: ets:tid(),
    order_table :: ets:tid()
}).

new(Capacity) when Capacity > 0 ->
    DataTid = ets:new(lru_data, [set, protected, {read_concurrency, true}]),
    OrderTid = ets:new(lru_order, [ordered_set, protected, {read_concurrency, true}]),
    #state{
        capacity = Capacity,
        data_table = DataTid,
        order_table = OrderTid
    }.

get(Key, #state{data_table = DataTid, order_table = OrderTid} = State) ->
    case ets:lookup(DataTid, Key) of
        [{Key, {Value, OldOrderIndex}}] ->
            NewOrderIndex = erlang:monotonic_time(nanosecond),
            ets:insert(DataTid, {Key, {Value, NewOrderIndex}}),
            ets:delete(OrderTid, OldOrderIndex),
            ets:insert(OrderTid, {NewOrderIndex, Key}),
            {Value, State};
        [] ->
            {-1, State}
    end.

put(Key, Value, #state{capacity = Capacity, data_table = DataTid, order_table = OrderTid} = State) ->
    NewOrderIndex = erlang:monotonic_time(nanosecond),
    case ets:lookup(DataTid, Key) of
        [{Key, {_, OldOrderIndex}}] ->
            ets:insert(DataTid, {Key, {Value, NewOrderIndex}}),
            ets:delete(OrderTid, OldOrderIndex),
            ets:insert(OrderTid, {NewOrderIndex, Key});
        [] ->
            CurrentSize = ets:info(DataTid, size),
            if
                CurrentSize >= Capacity ->
                    MinOrderIndex = ets:first(OrderTid),
                    LRU_Key = ets:lookup_element(OrderTid, MinOrderIndex, 2),
                    ets:delete(DataTid, LRU_Key),
                    ets:delete(OrderTid, MinOrderIndex);
                true ->
                    ok
            end,
            ets:insert(DataTid, {Key, {Value, NewOrderIndex}}),
            ets:insert(OrderTid, {NewOrderIndex, Key})
    end,
    State.