-spec check_ones_segment(S :: unicode:unicode_binary()) -> boolean().
check_ones_segment(S) ->
    case binary:split(S, <<"0">>, [global]) of
        [<<>>] -> false;
        [<<>>, _] -> false;
        [_ | Rest] -> length(Rest) =< 1
    end.