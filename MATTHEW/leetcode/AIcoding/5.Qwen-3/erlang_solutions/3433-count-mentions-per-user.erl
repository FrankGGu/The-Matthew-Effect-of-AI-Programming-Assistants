-module(count_mentions_per_user).
-export([count_mentions/1]).

count_mentions(Posts) ->
    count_mentions(Posts, #{}).

count_mentions([], Acc) ->
    Acc;
count_mentions([Post | Rest], Acc) ->
    Users = get_users(Post),
    UpdatedAcc = update_acc(Acc, Users),
    count_mentions(Rest, UpdatedAcc).

get_users(Post) ->
    Words = string:split(Post, " "),
    [User || Word <- Words, is_mention(Word)].

is_mention(Word) ->
    string:left(Word, 1) == "@".

update_acc(Acc, []) ->
    Acc;
update_acc(Acc, [User | Rest]) ->
    Count = maps:get(User, Acc, 0),
    NewAcc = maps:put(User, Count + 1, Acc),
    update_acc(NewAcc, Rest).