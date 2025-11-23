-spec check_string(S :: unicode:unicode_binary()) -> boolean().
check_string(S) ->
    case binary:match(S, <<"ba">>) of
        nomatch -> true;
        _ -> false
    end.