-spec minimum_operations(Num :: unicode:unicode_binary()) -> integer().
minimum_operations(Num) ->
    S = unicode:characters_to_list(Num),
    Len = length(S),
    MinOps = lists:min([
        find_min_ops(S, Len, "00"),
        find_min_ops(S, Len, "25"),
        find_min_ops(S, Len, "50"),
        find_min_ops(S, Len, "75")
    ]),
    case MinOps of
        infinity -> if Len == 1 -> 1; true -> Len - 1 end;
        _ -> MinOps
    end.

find_min_ops(S, Len, Target) ->
    [T1, T2] = Target,
    {Pos1, Pos2} = find_positions(S, T1, T2),
    case {Pos1, Pos2} of
        {not_found, _} -> infinity;
        {_, not_found} -> infinity;
        {P1, P2} when P1 < P2 -> (Len - P2 - 1) + (P2 - P1 - 1);
        _ -> infinity
    end.

find_positions(S, T1, T2) ->
    P1 = find_last(S, T1),
    P2 = find_last_after(S, T2, P1),
    {P1, P2}.

find_last(S, Char) ->
    case lists:last([I || {I, C} <- lists:zip(lists:seq(0, length(S) - 1), S), C == Char]) of
        [] -> not_found;
        Pos -> Pos
    end.

find_last_after(S, Char, After) ->
    case lists:last([I || {I, C} <- lists:zip(lists:seq(0, length(S) - 1), S), C == Char, I > After]) of
        [] -> not_found;
        Pos -> Pos
    end.