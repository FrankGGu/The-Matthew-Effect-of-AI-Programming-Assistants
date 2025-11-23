-module(tweet_counts).
-export([TweetCounts/3, get_time/1, add_tweet/2, get_counts/3]).

-record(tweet, {time, count = 1}).
-record(tweet_counts, {tweets = #{} }).

TweetCounts(Freq, Tweets, Time) ->
    Counts = lists:foldl(fun({User, TimeStr}, Acc) ->
        TimeStamp = get_time(TimeStr),
        NewAcc = add_tweet(User, TimeStamp, Acc),
        NewAcc
    end, #tweet_counts{}, Tweets),
    get_counts(Freq, Time, Counts).

get_time(TimeStr) ->
    {Year, Month, Day, Hour, Minute} = 
        {list_to_integer(binary_to_list(string:substr(TimeStr, 0, 4))),
         list_to_integer(binary_to_list(string:substr(TimeStr, 5, 2))),
         list_to_integer(binary_to_list(string:substr(TimeStr, 8, 2))),
         list_to_integer(binary_to_list(string:substr(TimeStr, 11, 2))),
         list_to_integer(binary_to_list(string:substr(TimeStr, 14, 2)))},
    calendar:datetime_to_gregorian_days({Year, Month, Day}) * 86400 + Hour * 3600 + Minute * 60.

add_tweet(User, TimeStamp, #tweet_counts{tweets = Tweets}) ->
    case maps:find(User, Tweets) of
        {ok, #tweet{time = T, count = C}} when T == TimeStamp ->
            NewTweet = #tweet{time = T, count = C + 1},
            #tweet_counts{tweets = maps:put(User, NewTweet, Tweets)};
        _ ->
            NewTweet = #tweet{time = TimeStamp, count = 1},
            #tweet_counts{tweets = maps:put(User, NewTweet, Tweets)}
    end.

get_counts(Freq, Time, #tweet_counts{tweets = Tweets}) ->
    case maps:fold(fun(_, #tweet{time = T, count = C}, Acc) ->
            case T div Freq of
                TDiv -> 
                    Acc1 = lists:append(Acc, [{TDiv, C}]),
                    Acc1;
                _ -> 
                    Acc
            end
        end, [], Tweets) of
        [] -> lists:duplicate(length(Time), 0);
        Counts -> 
            lists:map(fun({_, Count}) -> Count end, Counts)
    end.