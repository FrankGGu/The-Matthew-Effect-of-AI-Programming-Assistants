-module(solution).
-export([remove_stones/1]).

remove_stones(Stones) ->
    Parent = maps:new(),
    Count = length(Stones),
    UnionFind = {Parent, Count},
    {_, UF} = lists:foldl(fun([X, Y], Acc) ->
        {P, C} = Acc,
        KeyX = {x, X},
        KeyY = {y, Y},
        P1 = case maps:is_key(KeyX, P) of
            true -> P;
            false -> maps:put(KeyX, KeyX, P)
        end,
        P2 = case maps:is_key(KeyY, P1) of
            true -> P1;
            false -> maps:put(KeyY, KeyY, P1)
        end,
        RootX = find(KeyX, P2),
        RootY = find(KeyY, P2),
        case RootX =:= RootY of
            true -> {P2, C};
            false -> {maps:put(RootY, RootX, P2), C - 1}
        end
    end, UnionFind, Stones),
    Count - (element(2, UF)).

find(Key, Parent) ->
    case maps:get(Key, Parent) of
        Key -> Key;
        P -> 
            Root = find(P, Parent),
            maps:put(Key, Root, Parent),
            Root
    end.