-spec min_length(S :: unicode:unicode_binary()) -> integer().
min_length(S) ->
    case binary:match(S, <<"AB">>) of
        nomatch ->
            case binary:match(S, <<"CD">>) of
                nomatch -> byte_size(S);
                _ -> min_length(remove_substring(S, <<"CD">>))
            end;
        _ -> min_length(remove_substring(S, <<"AB">>))
    end.

remove_substring(S, Sub) ->
    {Before, After} = binary:split(S, Sub),
    <<Before/binary, After/binary>>.