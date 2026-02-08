%% Define the state record for Twitter.
%% - The state includes a list of users, each with their own tweets and followees.

-record(user, {tweets = [], follows = []}).

%% Initialize the Twitter system.
-spec twitter_init() -> any().
twitter_init() ->
    %% The state is a map where keys are user IDs.
    %{}.

%% Post a tweet.
-spec twitter_post_tweet(State :: map(), UserId :: integer(), TweetId :: integer()) -> map().
twitter_post_tweet(State, UserId, TweetId) ->
    case maps:find(UserId, State) of
        {ok, User} ->
            UserUpdated = #user{User | tweets = [TweetId | User#user.tweets]},
            maps:put(UserId, UserUpdated, State);
        error -> 
            NewUser = #user{tweets = [TweetId]},
            maps:put(UserId, NewUser, State)
    end.

%% Get the news feed for a user.
-spec twitter_get_news_feed(State :: map(), UserId :: integer()) -> [integer()].
twitter_get_news_feed(State, UserId) ->
    case maps:find(UserId, State) of
        {ok, User} ->
            %% Get tweets from the user and the users they follow.
            UserTweets = User#user.tweets,
            Followees = User#user.follows,
            FolloweeTweets = lists:flatmap(fun(FolloweeId) -> 
                                              case maps:find(FolloweeId, State) of
                                                  {ok, Followee} -> Followee#user.tweets;
                                                  error -> []
                                              end
                                          end, Followees),
            %% Combine and get the 10 most recent tweets.
            lists:sublist(lists:sort(append(UserTweets, FolloweeTweets)), 10);
        error -> []
    end.

%% Follow a user.
-spec twitter_follow(State :: map(), FollowerId :: integer(), FolloweeId :: integer()) -> map().
twitter_follow(State, FollowerId, FolloweeId) ->
    case maps:find(FollowerId, State) of
        {ok, User} ->
            UserUpdated = #user{User | follows = [FolloweeId | User#user.follows]},
            maps:put(FollowerId, UserUpdated, State);
        error -> 
            NewUser = #user{follows = [FolloweeId]},
            maps:put(FollowerId, NewUser, State)
    end.

%% Unfollow a user.
-spec twitter_unfollow(State :: map(), FollowerId :: integer(), FolloweeId :: integer()) -> map().
twitter_unfollow(State, FollowerId, FolloweeId) ->
    case maps:find(FollowerId, State) of
        {ok, User} ->
            UserUpdated = #user{User | follows = lists:delete(FolloweeId, User#user.follows)},
            maps:put(FollowerId, UserUpdated, State);
        error -> State
    end.
