-spec can_jump(Nums :: [integer()]) -> boolean().
can_jump(Nums) ->
    can_jump(Nums, 0, 0).

can_jump([], _, _) -> true;
can_jump([_], _, _) -> true;
can_jump([H | T], Index, MaxReach) ->
    NewMaxReach = max(MaxReach, Index + H),
    case NewMaxReach >= length([H | T]) - 1 of
        true -> true;
        false when NewMaxReach > Index -> can_jump(T, Index + 1, NewMaxReach);
        false -> false
    end.