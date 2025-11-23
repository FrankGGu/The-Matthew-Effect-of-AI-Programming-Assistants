-spec repeated_string_match(A :: unicode:unicode_binary(), B :: unicode:unicode_binary()) -> integer().
repeated_string_match(A, B) ->
    case binary:match(B, A) of
        nomatch ->
            case binary:match(A, B) of
                nomatch -> -1;
                _ -> 1
            end;
        _ ->
            Count = ceil(byte_size(B) / byte_size(A)),
            case binary:match(string:copies(A, Count), B) of
                nomatch ->
                    case binary:match(string:copies(A, Count + 1), B) of
                        nomatch -> -1;
                        _ -> Count + 1
                    end;
                _ -> Count
            end
    end.