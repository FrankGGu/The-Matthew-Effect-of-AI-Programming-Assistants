-module(twitter).
-export([init/0, postTweet/2, getNewsFeed/1, follow/2, unfollow/2]).

-record(user, {id, tweets = [], following = sets:new()}).

init() ->
    ets:new(users, [set, named_table, public]),
    ets:new(tweets, [ordered_set, named_table, public, {keypos, 1}]),
    ok.

postTweet(UserId, TweetId) ->
    Time = erlang:system_time(micro_seconds),
    ets:insert(tweets, {TweetId, UserId, Time}),
    case ets:lookup(users, UserId) of
        [] ->
            ets:insert(users, #user{id = UserId, tweets = [TweetId]});
        [User] ->
            Tweets = [TweetId | User#user.tweets],
            ets:insert(users, User#user{tweets = Tweets})
    end,
    ok.

getNewsFeed(UserId) ->
    case ets:lookup(users, UserId) of
        [] -> [];
        [User] ->
            Following = sets:to_list(User#user.following),
            AllUsers = [UserId | Following],
            Tweets = lists:foldl(
                fun(U, Acc) ->
                    case ets:lookup(users, U) of
                        [] -> Acc;
                        [UUser] ->
                            lists:foldl(
                                fun(T, Acc1) ->
                                    case ets:lookup(tweets, T) of
                                        [{_, _, Time}] -> [{Time, T} | Acc1];
                                        _ -> Acc1
                                    end
                                end,
                                Acc,
                                UUser#user.tweets
                            )
                    end
                end,
                [],
                AllUsers
            ),
            Sorted = lists:sort(fun({T1, _}, {T2, _}) -> T1 > T2 end, Tweets),
            Top10 = lists:sublist(Sorted, 10),
            [T || {_, T} <- Top10]
    end.

follow(FollowerId, FolloweeId) ->
    case FollowerId =:= FolloweeId of
        true -> ok;
        false ->
            case ets:lookup(users, FollowerId) of
                [] ->
                    Following = sets:add_element(FolloweeId, sets:new()),
                    ets:insert(users, #user{id = FollowerId, following = Following});
                [User] ->
                    Following = sets:add_element(FolloweeId, User#user.following),
                    ets:insert(users, User#user{following = Following})
            end,
            ok
    end.

unfollow(FollowerId, FolloweeId) ->
    case ets:lookup(users, FollowerId) of
        [] -> ok;
        [User] ->
            Following = sets:del_element(FolloweeId, User#user.following),
            ets:insert(users, User#user{following = Following}),
            ok
    end.