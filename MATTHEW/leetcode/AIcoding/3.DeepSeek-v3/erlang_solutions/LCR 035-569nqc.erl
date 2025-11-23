-spec find_min_difference(TimePoints :: [unicode:unicode_binary()]) -> integer().
find_min_difference(TimePoints) ->
    Times = lists:map(fun(Time) ->
        [H, M] = binary:split(Time, <<":">>, [global]),
        binary_to_integer(H) * 60 + binary_to_integer(M)
    end, TimePoints),
    Sorted = lists:sort(Times),
    MinDiff = lists:min(lists:zipwith(fun(A, B) -> B - A end, Sorted, tl(Sorted) ++ [hd(Sorted) + 1440])),
    min(MinDiff, 1440 - MinDiff).