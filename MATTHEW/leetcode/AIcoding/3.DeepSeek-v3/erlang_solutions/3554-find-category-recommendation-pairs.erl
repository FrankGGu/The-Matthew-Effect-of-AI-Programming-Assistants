-module(solution).
-export([recommend_pairs/1]).

recommend_pairs(Friends) ->
    FriendMap = build_friend_map(Friends),
    Categories = build_category_map(Friends, FriendMap),
    Pairs = find_pairs(Friends, FriendMap, Categories),
    lists:sort(Pairs).

build_friend_map(Friends) ->
    lists:foldl(fun([A, B], Map) ->
        Map1 = maps:update_with(A, fun(Set) -> sets:add_element(B, Set) end, sets:from_list([B]), Map),
        maps:update_with(B, fun(Set) -> sets:add_element(A, Set) end, sets:from_list([A]), Map1)
    end, #{}, Friends).

build_category_map(Friends, FriendMap) ->
    lists:foldl(fun([A, B, Cat], Map) ->
        Map1 = maps:update_with(A, fun(Cats) -> maps:update_with(Cat, fun(S) -> sets:add_element(B, S) end, sets:from_list([B]), Cats) end, #{Cat => sets:from_list([B])}, Map),
        maps:update_with(B, fun(Cats) -> maps:update_with(Cat, fun(S) -> sets:add_element(A, S) end, sets:from_list([A]), Cats) end, #{Cat => sets:from_list([A])}, Map1)
    end, #{}, Friends).

find_pairs(Friends, FriendMap, Categories) ->
    AllPairs = lists:foldl(fun([A, B, _], Acc) ->
        case A < B of
            true -> sets:add_element({A, B}, Acc);
            false -> sets:add_element({B, A}, Acc)
        end
    end, sets:new(), Friends),
    Users = maps:keys(FriendMap),
    Pairs = lists:foldl(fun(A, Acc1) ->
        lists:foldl(fun(B, Acc2) ->
            case A < B andalso not sets:is_element({A, B}, AllPairs) andalso not sets:is_element(A, maps:get(B, FriendMap, sets:new())) of
                true ->
                    CommonCats = find_common_categories(A, B, Categories),
                    case CommonCats of
                        [] -> Acc2;
                        _ -> [{A, B, CommonCats} | Acc2]
                    end;
                false -> Acc2
            end
        end, Acc1, Users)
    end, [], Users),
    lists:map(fun({A, B, Cats}) -> [A, B, lists:sort(Cats)] end, Pairs).

find_common_categories(A, B, Categories) ->
    ACats = maps:get(A, Categories, #{}),
    BCats = maps:get(B, Categories, #{}),
    lists:sort(maps:keys(maps:filter(fun(Cat, _) -> maps:is_key(Cat, BCats) end, ACats))).