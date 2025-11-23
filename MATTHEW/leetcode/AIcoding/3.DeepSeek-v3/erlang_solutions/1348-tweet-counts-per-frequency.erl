-record(tweet, {name, time}).

-record(tweet_counts, {
    freq_map = #{} :: #{binary() => #{atom() => [integer()]}}
}).

-spec init_() -> any().
init_() ->
    #tweet_counts{}.

-spec record_tweet(TweetCounts :: any(), TweetName :: binary(), Time :: integer()) -> any().
record_tweet(TweetCounts, TweetName, Time) ->
    case maps:get(TweetName, TweetCounts#tweet_counts.freq_map, undefined) of
        undefined ->
            NewMap = maps:put(TweetName, #{}, TweetCounts#tweet_counts.freq_map),
            TweetCounts#tweet_counts{freq_map = NewMap};
        FreqMap ->
            NewFreqMap = maps:put(Time, true, FreqMap),
            NewMap = maps:put(TweetName, NewFreqMap, TweetCounts#tweet_counts.freq_map),
            TweetCounts#tweet_counts{freq_map = NewMap}
    end.

-spec get_tweet_counts_per_frequency(TweetCounts :: any(), Freq :: atom(), TweetName :: binary(), StartTime :: integer(), EndTime :: integer()) -> [integer()].
get_tweet_counts_per_frequency(TweetCounts, Freq, TweetName, StartTime, EndTime) ->
    case maps:get(TweetName, TweetCounts#tweet_counts.freq_map, undefined) of
        undefined ->
            [];
        FreqMap ->
            Interval = case Freq of
                minute -> 60;
                hour -> 3600;
                day -> 86400;
                _ -> 60
            end,
            Times = lists:sort(maps:keys(FreqMap)),
            FilteredTimes = lists:filter(fun(T) -> T >= StartTime andalso T =< EndTime end, Times),
            calculate_intervals(FilteredTimes, StartTime, EndTime, Interval)
    end.

calculate_intervals(Times, StartTime, EndTime, Interval) ->
    NumIntervals = ((EndTime - StartTime) div Interval) + 1,
    Intervals = lists:map(fun(I) -> 
        IntervalStart = StartTime + I * Interval,
        IntervalEnd = IntervalStart + Interval - 1,
        {IntervalStart, IntervalEnd}
    end, lists:seq(0, NumIntervals - 1)),
    Counts = lists:map(fun({Start, End}) ->
        lists:foldl(fun(T, Acc) -> 
            if 
                T >= Start andalso T =< End -> Acc + 1;
                true -> Acc
            end
        end, 0, Times)
    end, Intervals),
    Counts.