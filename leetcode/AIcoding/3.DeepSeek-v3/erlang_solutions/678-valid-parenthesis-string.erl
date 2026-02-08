-spec check_valid_string(S :: unicode:unicode_binary()) -> boolean().
check_valid_string(S) ->
    check_valid_string(binary_to_list(S), 0, 0).

check_valid_string([], Low, High) ->
    Low =< 0 andalso 0 =< High;
check_valid_string([$( | Rest], Low, High) ->
    check_valid_string(Rest, Low + 1, High + 1);
check_valid_string([$) | Rest], Low, High) ->
    NewLow = max(Low - 1, 0),
    NewHigh = High - 1,
    if
        NewHigh < 0 -> false;
        true -> check_valid_string(Rest, NewLow, NewHigh)
    end;
check_valid_string([$* | Rest], Low, High) ->
    NewLow = max(Low - 1, 0),
    NewHigh = High + 1,
    check_valid_string(Rest, NewLow, NewHigh).