-spec jump(Nums :: [integer()]) -> integer().
jump(Nums) ->
    jump(Nums, 0, 0, 0).

jump([], _, Jumps, _) -> Jumps;
jump([_], _, Jumps, _) -> Jumps;
jump([H|T], Index, Jumps, MaxReach) ->
    NewMaxReach = max(Index + H, MaxReach),
    if
        Index == Jumps ->
            jump(T, Index + 1, Jumps + 1, NewMaxReach);
        true ->
            jump(T, Index + 1, Jumps, NewMaxReach)
    end.