-module(twitter).
-export([init/0, postTweet/3, getNewsFeed/2, follow/3, unfollow/3]).

init() ->
    {maps:new(), [], 0}.

postTweet(UserId, TweetId, {Followers, Tweets, Timestamp}) ->
    NewTimestamp = Timestamp + 1,
    NewTweets = [{NewTimestamp, UserId, TweetId} | Tweets],
    {Followers, NewTweets, NewTimestamp}.

getNewsFeed(UserId, {Followers, Tweets, _Timestamp}) ->
    UserFollowees = maps:get(UserId, Followers, sets:new()),
    AllRelevantUsers = sets:add_element(UserId, UserFollowees),
    FilteredTweets = lists:filter(
        fun({_TS, TweetPosterId, _TID}) ->
            sets:is_element(TweetPosterId, AllRelevantUsers)
        end,
        Tweets
    ),
    lists:sublist(lists:map(fun({_TS, _UID, TID}) -> TID end, FilteredTweets), 10).

follow(FollowerId, FolloweeId, {Followers, Tweets, Timestamp}) ->
    CurrentFollowees = maps:get(FollowerId, Followers, sets:new()),
    NewFollowees = sets:add_element(FolloweeId, CurrentFollowees),
    NewFollowers = maps:put(FollowerId, NewFollowees, Followers),
    {NewFollowers, Tweets, Timestamp}.

unfollow(FollowerId, FolloweeId, {Followers, Tweets, Timestamp}) ->
    CurrentFollowees = maps:get(FollowerId, Followers, sets:new()),
    NewFollowees = sets:del_element(FolloweeId, CurrentFollowees),
    NewFollowers = maps:put(FollowerId, NewFollowees, Followers),
    {NewFollowers, Tweets, Timestamp}.