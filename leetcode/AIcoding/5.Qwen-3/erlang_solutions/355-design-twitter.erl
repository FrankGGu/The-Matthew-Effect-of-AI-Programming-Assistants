-module(twitter).
-export([new/0, postTweet/2, getNewsFeed/1, follow/2, unfollow/1]).

-record(user, {id, tweets = [], followers = []}).

new() ->
    #{}.

postTweet(UserId, TweetId) ->
    Users = get_users(),
    User = maps:get(UserId, Users, #user{id = UserId}),
    NewTweets = [TweetId | User#user.tweets],
    NewUser = User#user{tweets = NewTweets},
    put_users(maps:put(UserId, NewUser, Users)).

getNewsFeed(UserId) ->
    Users = get_users(),
    User = maps:get(UserId, Users),
    FollowedUsers = lists:map(fun(FollowId) -> maps:get(FollowId, Users) end, User#user.followers),
    AllTweets = [User#user.tweets] ++ [U#user.tweets || U <- FollowedUsers],
    Sorted = lists:sort(fun(A, B) -> A > B end, lists:flatten(AllTweets)),
    lists:sublist(Sorted, 10).

follow(FollowerId, FolloweeId) ->
    Users = get_users(),
    Follower = maps:get(FollowerId, Users, #user{id = FollowerId}),
    Followee = maps:get(FolloweeId, Users, #user{id = FolloweeId}),
    NewFollowers = lists:usort([FolloweeId | Follower#user.followers]),
    NewFollower = Follower#user{followers = NewFollowers},
    NewFollowee = Followee#user{followers = lists:usort([FollowerId | Followee#user.followers])},
    put_users(maps:put(FollowerId, NewFollower, maps:put(FolloweeId, NewFollowee, Users))).

unfollow(FollowerId, FolloweeId) ->
    Users = get_users(),
    Follower = maps:get(FollowerId, Users),
    Followee = maps:get(FolloweeId, Users),
    NewFollowers = lists:delete(FolloweeId, Follower#user.followers),
    NewFollower = Follower#user{followers = NewFollowers},
    NewFollowee = Followee#user{followers = lists:delete(FollowerId, Followee#user.followers)},
    put_users(maps:put(FollowerId, NewFollower, maps:put(FolloweeId, NewFollowee, Users))).

get_users() ->
    erlang:get(twitter_users).

put_users(Users) ->
    erlang:put(twitter_users, Users).