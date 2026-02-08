-spec can_jump(Nums :: [integer()]) -> boolean().
can_jump(Nums) ->
    can_jump(Nums, 0).

can_jump([], _) -> true;
can_jump([_], _) -> true;
can_jump([Num | Rest], MaxReach) when MaxReach >= length([Num | Rest]) -> true;
can_jump([Num | Rest], MaxReach) when Num + MaxReach >= length([Num | Rest]) -> true;
can_jump([Num | Rest], MaxReach) when Num + MaxReach < length([Num | Rest]) -> false.
