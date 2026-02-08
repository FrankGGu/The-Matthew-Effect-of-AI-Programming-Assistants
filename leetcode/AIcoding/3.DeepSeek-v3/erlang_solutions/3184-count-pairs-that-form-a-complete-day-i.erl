-spec count_complete_day_pairs(Hours :: [integer()]) -> integer().
count_complete_day_pairs(Hours) ->
    Counts = maps:new(),
    count_complete_day_pairs(Hours, Counts, 0).

count_complete_day_pairs([], _, Acc) ->
    Acc;
count_complete_day_pairs([H | T], Counts, Acc) ->
    Rem = H rem 24,
    Needed = (24 - Rem) rem 24,
    case maps:get(Needed, Counts, 0) of
        0 -> ok;
        N -> Acc1 = Acc + N
    end,
    Counts1 = maps:update_with(Rem, fun(V) -> V + 1 end, 1, Counts),
    count_complete_day_pairs(T, Counts1, case Acc1 of undefined -> Acc; _ -> Acc1 end).