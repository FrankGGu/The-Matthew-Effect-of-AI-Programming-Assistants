-spec can_break(S1 :: unicode:unicode_binary(), S2 :: unicode:unicode_binary()) -> boolean().
can_break(S1, S2) ->
    L1 = lists:sort(binary_to_list(S1)),
    L2 = lists:sort(binary_to_list(S2)),
    can_break_helper(L1, L2, true) orelse can_break_helper(L2, L1, true).

can_break_helper([], [], Flag) -> Flag;
can_break_helper([H1|T1], [H2|T2], Flag) ->
    case H1 >= H2 of
        true -> can_break_helper(T1, T2, Flag);
        false -> can_break_helper(T1, T2, false)
    end.