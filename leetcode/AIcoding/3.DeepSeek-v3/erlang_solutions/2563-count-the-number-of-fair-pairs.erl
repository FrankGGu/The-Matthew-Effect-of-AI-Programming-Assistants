-spec count_fair_pairs(Nums :: [integer()], Lower :: integer(), Upper :: integer()) -> integer().
count_fair_pairs(Nums, Lower, Upper) ->
    Sorted = lists:sort(Nums),
    count_pairs(Sorted, Lower, Upper, 0).

count_pairs([], _, _, Count) -> Count;
count_pairs([H | T], Lower, Upper, Count) ->
    L = Lower - H,
    U = Upper - H,
    Left = find_lower_bound(T, L),
    Right = find_upper_bound(T, U),
    NewCount = Count + Right - Left,
    count_pairs(T, Lower, Upper, NewCount).

find_lower_bound(List, Target) ->
    find_lower_bound(List, Target, 0, length(List)).

find_lower_bound(List, Target, Low, High) when Low < High ->
    Mid = (Low + High) div 2,
    case lists:nth(Mid + 1, List) of
        X when X < Target -> find_lower_bound(List, Target, Mid + 1, High);
        _ -> find_lower_bound(List, Target, Low, Mid)
    end;
find_lower_bound(_, _, Low, _) -> Low.

find_upper_bound(List, Target) ->
    find_upper_bound(List, Target, 0, length(List)).

find_upper_bound(List, Target, Low, High) when Low < High ->
    Mid = (Low + High) div 2,
    case lists:nth(Mid + 1, List) of
        X when X =< Target -> find_upper_bound(List, Target, Mid + 1, High);
        _ -> find_upper_bound(List, Target, Low, Mid)
    end;
find_upper_bound(_, _, Low, _) -> Low.