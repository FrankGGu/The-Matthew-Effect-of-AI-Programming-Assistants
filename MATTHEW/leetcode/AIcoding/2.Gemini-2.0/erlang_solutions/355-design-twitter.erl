-module(twitter).
-export([start/0, postTweet/2, getNewsFeed/3, follow/3, unfollow/3]).

-record(user, {id, tweets = [], following = []}).
-record(tweet, {id, userId, timestamp}).

-define(SERVER, twitter_server).

start() ->
    register(?SERVER, spawn(fun() -> loop(#{}) end)).

postTweet(UserId, TweetId) ->
    ?SERVER ! {post, UserId, TweetId},
    ok.

getNewsFeed(UserId, Limit) ->
    {ok, lists:sublist(get_news_feed(UserId), Limit)}.

follow(FollowerId, FolloweeId) ->
    ?SERVER ! {follow, FollowerId, FolloweeId},
    ok.

unfollow(FollowerId, FolloweeId) ->
    ?SERVER ! {unfollow, FollowerId, FolloweeId},
    ok.

get_news_feed(UserId) ->
    ?SERVER ! {get_feed, UserId, self()},
    receive
        {feed, Feed} ->
            Feed
    end.

loop(State) ->
    receive
        {post, UserId, TweetId} ->
            NewState = post_tweet(UserId, TweetId, State),
            loop(NewState);
        {follow, FollowerId, FolloweeId} ->
            NewState = follow_user(FollowerId, FolloweeId, State),
            loop(NewState);
        {unfollow, FollowerId, FolloweeId} ->
            NewState = unfollow_user(FollowerId, FolloweeId, State),
            loop(NewState);
        {get_feed, UserId, Pid} ->
            Feed = get_user_feed(UserId, State),
            Pid ! {feed, Feed},
            loop(State)
    end.

post_tweet(UserId, TweetId, State) ->
    Now = erlang:system_time(millisecond),
    Tweet = #tweet{id = TweetId, userId = UserId, timestamp = Now},
    case maps:is_key(UserId, State) of
        true ->
            User = maps:get(UserId, State),
            NewUser = User#user{tweets = [Tweet | User#user.tweets]},
            maps:put(UserId, NewUser, State);
        false ->
            NewUser = #user{id = UserId, tweets = [Tweet]},
            maps:put(UserId, NewUser, State)
    end.

follow_user(FollowerId, FolloweeId, State) ->
    case maps:is_key(FollowerId, State) of
        true ->
            User = maps:get(FollowerId, State),
            NewUser = case lists:member(FolloweeId, User#user.following) of
                true -> User;
                false -> User#user{following = [FolloweeId | User#user.following]}
            end,
            maps:put(FollowerId, NewUser, State);
        false ->
            NewUser = #user{id = FollowerId, following = [FolloweeId]},
            maps:put(FollowerId, NewUser, State)
    end.

unfollow_user(FollowerId, FolloweeId, State) ->
    case maps:is_key(FollowerId, State) of
        true ->
            User = maps:get(FollowerId, State),
            NewUser = User#user{following = lists:delete(FolloweeId, User#user.following)},
            maps:put(FollowerId, NewUser, State);
        false ->
            State
    end.

get_user_feed(UserId, State) ->
    case maps:is_key(UserId, State) of
        true ->
            User = maps:get(UserId, State),
            Following = User#user.following,
            UserTweets = User#user.tweets,
            FollowingTweets = lists:foldl(
                fun(FolloweeId, Acc) ->
                    case maps:is_key(FolloweeId, State) of
                        true ->
                            Followee = maps:get(FolloweeId, State),
                            Acc ++ Followee#user.tweets;
                        false ->
                            Acc
                    end
                end,
                [],
                Following
            ),
            AllTweets = UserTweets ++ FollowingTweets,
            SortedTweets = lists:sort(fun(A, B) -> A#tweet.timestamp > B#tweet.timestamp end, AllTweets),
            [Tweet#tweet.id || Tweet <- SortedTweets];
        false ->
            []
    end.