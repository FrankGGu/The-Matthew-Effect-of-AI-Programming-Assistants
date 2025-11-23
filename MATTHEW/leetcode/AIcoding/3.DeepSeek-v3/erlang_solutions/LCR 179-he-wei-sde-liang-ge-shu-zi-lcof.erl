-spec two_sum(ShoppingList :: [integer()], Target :: integer()) -> [integer()].
two_sum(ShoppingList, Target) ->
    Map = maps:new(),
    two_sum(ShoppingList, Target, Map, 1).

two_sum([], _, _, _) -> [];
two_sum([H | T], Target, Map, Index) ->
    case maps:get(Target - H, Map, undefined) of
        undefined ->
            NewMap = maps:put(H, Index, Map),
            two_sum(T, Target, NewMap, Index + 1);
        OtherIndex ->
            [OtherIndex, Index]
    end.