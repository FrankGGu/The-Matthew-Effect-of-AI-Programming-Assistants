-module(tweet_counts_per_frequency).
-export([tweet_counts_per_frequency/3]).

tweet_counts_per_frequency(Freq, S, T) ->
    {ok, Pid} = gen_server:start_link(?MODULE, [], []),
    gen_server:call(Pid, {add, S, T}),
    gen_server:call(Pid, {get, Freq}).

init([]) ->
    {ok, #{}).

handle_call({add, S, T}, _From, State) ->
    Map = maps:update_with(S, fun(Val) -> [T | Val] end, [T], State),
    {reply, ok, Map}.

handle_call({get, Freq}, _From, State) ->
    Keys = maps:keys(State),
    Results = lists:map(fun(Key) -> {Key, process_tweets(Key, maps:get(Key, State), Freq)} end, Keys),
    {reply, Results, State}.

process_tweets(User, Times, Freq) ->
    SortedTimes = lists:sort(Times),
    Interval = case Freq of
        "minute" -> 60;
        "hour" -> 3600;
        "day" -> 86400
    end,
    Groups = group_by_interval(SortedTimes, 0, Interval, []),
    lists:map(fun({Start, End, Count}) -> {Start, Count} end, Groups).

group_by_interval([], _, _, Acc) ->
    Acc;
group_by_interval([T | Ts], CurrentStart, Interval, Acc) ->
    Start = (T div Interval) * Interval,
    if
        Start == CurrentStart ->
            group_by_interval(Ts, CurrentStart, Interval, Acc);
        true ->
            NewAcc = [{CurrentStart, (CurrentStart + Interval - 1), length(Acc)} | Acc],
            group_by_interval([T | Ts], Start, Interval, [])
    end.

handle_cast(_Msg, State) ->
    {noreply, State}.

handle_info(_Info, State) ->
    {noreply, State}.

terminate(_Reason, _State) ->
    ok.

code_change(_OldVsn, State, _Extra) ->
    {ok, State}.