-module(tweet_counts_per_frequency).
-export([start/0, record_tweet/3, get_tweets_per_frequency/4]).

start() ->
    ets:new(tweets, [named_table, public, ordered_set]).

record_tweet(TweetName, Time, Pid) ->
    ets:insert(tweets, {TweetName, Time}),
    Pid ! {recorded, TweetName, Time}.

get_tweets_per_frequency(TweetName, StartTime, EndTime, Frequency, Pid) ->
    Interval = case Frequency of
        "minute" -> 60;
        "hour"   -> 3600;
        "day"    -> 86400
    end,
    Counts = get_counts(TweetName, StartTime, EndTime, Interval),
    Pid ! {counts, TweetName, StartTime, EndTime, Frequency, Counts}.

get_counts(TweetName, StartTime, EndTime, Interval) ->
    get_counts(TweetName, StartTime, EndTime, Interval, []).

get_counts(TweetName, StartTime, EndTime, Interval, Acc) ->
    case StartTime > EndTime of
        true ->
            lists:reverse(Acc);
        false ->
            NextEndTime = min(StartTime + Interval - 1, EndTime),
            Count = count_tweets(TweetName, StartTime, NextEndTime),
            get_counts(TweetName, NextEndTime + 1, EndTime, Interval, [Count | Acc])
    end.

count_tweets(TweetName, StartTime, EndTime) ->
    count_tweets(TweetName, StartTime, EndTime, 0).

count_tweets(TweetName, StartTime, EndTime, Count) ->
    case ets:lookup(tweets, {TweetName, StartTime}) of
        [] ->
            case StartTime > EndTime of
                true ->
                    Count;
                false ->
                    count_tweets(TweetName, StartTime + 1, EndTime, Count)
            end;
        [_] ->
            count_tweets(TweetName, StartTime + 1, EndTime, Count + 1)
    end.