-spec find_min_difference(TimePoints :: [unicode:unicode_binary()]) -> integer().
find_min_difference(TimePoints) ->
    Times = lists:map(fun(Time) ->
        [H, M] = binary:split(Time, <<":">>),
        {binary_to_integer(H), binary_to_integer(M)}
    end, TimePoints),
    Sorted = lists:sort(Times),
    MinDiff = lists:min(lists:map(fun({H1, M1}, {H2, M2}) ->
        (H2 * 60 + M2 - H1 * 60 - M1) rem 1440
    end, lists:zip(Sorted, tl(Sorted) ++ [hd(Sorted)]))),
    MinDiff.