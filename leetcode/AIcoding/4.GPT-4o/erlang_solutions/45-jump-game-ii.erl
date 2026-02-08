-spec jump(Nums :: [integer()]) -> integer().
jump(Nums) ->
    jump(Nums, 0, 0, 0).

jump([], Jumps, _, _) -> Jumps;
jump([_ | Rest], Jumps, Start, End) when Start < length(Rest) ->
    jump(Rest, Jumps + 1, Start + 1, Start + 1 + hd(Rest));
jump([_ | Rest], Jumps, _, End) -> jump(Rest, Jumps, Start + 1, End).
