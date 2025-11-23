-spec find_original_string(Encoded :: unicode:unicode_binary()) -> unicode:unicode_binary().
find_original_string(Encoded) ->
    find_original_string(Encoded, <<>>).

find_original_string(<<>>, Acc) ->
    Acc;
find_original_string(<<C, Rest/binary>>, Acc) ->
    case binary:match(Acc, <<C>>) of
        nomatch ->
            find_original_string(Rest, <<Acc/binary, C>>);
        _ ->
            find_original_string(Rest, Acc)
    end.