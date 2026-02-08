-module(count_unhappy_friends).
-export([unhappyFriends/2]).

unhappyFriends(Dislikes, Friends) ->
    DislikesMap = maps:from_list(Dislikes),
    FriendsMap = maps:from_list(Friends),
    Unhappy = lists:foldl(fun(Id, Acc) ->
        case getUnhappy(Id, DislikesMap, FriendsMap) of
            true -> [Id | Acc];
            false -> Acc
        end
    end, [], lists:seq(0, 99)).

getUnhappy(Id, DislikesMap, FriendsMap) ->
    FriendsOfId = maps:get(Id, FriendsMap),
    lists:any(fun(Friend) ->
        case maps:is_key(Friend, DislikesMap) of
            true ->
                DislikedByFriend = maps:get(Friend, DislikesMap),
                lists:member(Id, DislikedByFriend);
            false ->
                false
        end
    end, FriendsOfId).