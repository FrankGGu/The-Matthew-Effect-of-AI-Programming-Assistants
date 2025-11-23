-module(stock_price).

-behaviour(gen_server).

-export([new/0]).
-export([update/3, current/1, maximum/1, minimum/1]).

-export([init/1, handle_call/3, handle_cast/2, handle_info/2, terminate/2, code_change/3]).

-record(state, {
    timestamps       = #{} :: map(),           % #{Timestamp => Price}
    max_heap         = gb_trees:empty() :: gb_trees:gb_tree(), % gb_trees of {Price, Timestamp}
    min_heap         = gb_trees:empty() :: gb_trees:gb_tree(), % gb_trees of {Price, Timestamp}
    latest_timestamp = 0 :: integer(),
    latest_price     = 0 :: integer()
}).

new() ->
    {ok, Pid} = gen_server:start_link(?MODULE, [], []),
    Pid.

update(Pid, Timestamp, Price) ->
    gen_server:call(Pid, {update, Timestamp, Price}).

current(Pid) ->
    gen_server:call(Pid, current).

maximum(Pid) ->
    gen_server:call(Pid, maximum).

minimum(Pid) ->
    gen_server:call(Pid, minimum).

init([]) ->
    {ok, #state{}}.

handle_call({update, Timestamp, Price}, _From, State) ->
    NewTimestamps = maps:put(Timestamp, Price, State#state.timestamps),
    NewMaxHeap = gb_trees:insert({Price, Timestamp}, State#state.max_heap),
    NewMinHeap = gb_trees:insert({Price, Timestamp}, State#state.min_heap),

    NewLatestTimestamp =
        case Timestamp >= State#state.latest_timestamp of
            true -> Timestamp;
            false -> State#state.latest_timestamp
        end,
    NewLatestPrice =
        case Timestamp >= State#state.latest_timestamp of
            true -> Price;
            false -> State#state.latest_price
        end,

    NewState = State#state{
        timestamps = NewTimestamps,
        max_heap = NewMaxHeap,
        min_heap = NewMinHeap,
        latest_timestamp = NewLatestTimestamp,
        latest_price = NewLatestPrice
    },
    {reply, ok, NewState}.

handle_call(current, _From, State) ->
    {reply, State#state.latest_price, State}.

handle_call(maximum, _From, State) ->
    {MaxPrice, NewMaxHeap} = find_max_and_clean(State#state.max_heap, State#state.timestamps),
    NewState = State#state{max_heap = NewMaxHeap},
    {reply, MaxPrice, NewState}.

handle_call(minimum, _From, State) ->
    {MinPrice, NewMinHeap} = find_min_and_clean(State#state.min_heap, State#state.timestamps),
    NewState = State#state{min_heap = NewMinHeap},
    {reply, MinPrice, NewState}.

handle_cast(_Msg, State) ->
    {noreply, State}.

handle_info(_Info, State) ->
    {noreply, State}.

terminate(_Reason, _State) ->
    ok.

code_change(_OldVsn, State, _Extra) ->
    {ok, State}.

find_max_and_clean(MaxHeap, TimestampsMap) ->
    case gb_trees:is_empty(MaxHeap) of
        true ->
            % According to problem constraints, update is called at least once before max/min.
            % So, the heap should not be empty. This case is for robustness.
            {error, empty_heap, MaxHeap};
        false ->
            {Price, Timestamp} = gb_trees:max(MaxHeap),
            case maps:get(Timestamp, TimestampsMap, undefined) of
                Price -> {Price, MaxHeap};
                _ ->
                    NewMaxHeap = gb_trees:delete({Price, Timestamp}, MaxHeap),
                    find_max_and_clean(NewMaxHeap, TimestampsMap)
            end
    end.

find_min_and_clean(MinHeap, TimestampsMap) ->
    case gb_trees:is_empty(MinHeap) of
        true ->
            {error, empty_heap, MinHeap};
        false ->
            {Price, Timestamp} = gb_trees:min(MinHeap),
            case maps:get(Timestamp, TimestampsMap, undefined) of
                Price -> {Price, MinHeap};
                _ ->
                    NewMinHeap = gb_trees:delete({Price, Timestamp}, MinHeap),
                    find_min_and_clean(NewMinHeap, TimestampsMap)
            end
    end.