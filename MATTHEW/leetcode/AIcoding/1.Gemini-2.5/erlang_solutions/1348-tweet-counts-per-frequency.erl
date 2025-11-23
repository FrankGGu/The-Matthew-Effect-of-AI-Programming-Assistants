-module(tweet_counts).
-export([new/0, recordTweet/3, getTweetCountsPerFrequency/5]).

new() ->
    #{}.

recordTweet(State, TweetName, Time) ->
    maps:update_with(TweetName, fun(Times) -> [Time | Times] end, [Time], State).

getTweetCountsPerFrequency(State, Freq, TweetName, StartTime, EndTime) ->
    Times = maps:get(TweetName, State, []),
    Delta = get_delta(Freq),
    NumIntervals = (EndTime - StartTime) div Delta + 1,

    % Calculate counts for relevant intervals
    % CountsMap: #{IntervalIndex => Count}
    CountsMap = lists:foldl(fun(Time, Acc) ->
                                if Time >= StartTime andalso Time =< EndTime ->
                                    Index = (Time - StartTime) div Delta,
                                    maps:update_with(Index, fun(C) -> C + 1 end, 1, Acc);
                                _ ->
                                    Acc
                                end
                            end, #{}, Times),

    % Construct the final list of counts for all intervals
    [maps:get(I, CountsMap, 0) || I <- lists:seq(0, NumIntervals - 1)].

get_delta("minute") -> 60;
get_delta("hour") -> 3600;
get_delta("day") -> 86400.