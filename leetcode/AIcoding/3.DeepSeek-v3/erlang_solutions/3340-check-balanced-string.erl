-spec check_balanced_string(S :: unicode:unicode_binary()) -> boolean().
check_balanced_string(S) ->
    check_balanced_string(S, 0).

check_balanced_string(<<>>, Count) ->
    Count == 0;
check_balanced_string(<<$(, Rest/binary>>, Count) ->
    check_balanced_string(Rest, Count + 1);
check_balanced_string(<<$), Rest/binary>>, Count) when Count > 0 ->
    check_balanced_string(Rest, Count - 1);
check_balanced_string(<<$), _Rest/binary>>, _Count) ->
    false;
check_balanced_string(<<$*, Rest/binary>>, Count) ->
    check_balanced_string(Rest, Count + 1) orelse
    (Count > 0 andalso check_balanced_string(Rest, Count - 1)) orelse
    check_balanced_string(Rest, Count);
check_balanced_string(_, _) ->
    false.