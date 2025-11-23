-spec encrypt_string(S :: unicode:unicode_binary()) -> unicode:unicode_binary().
encrypt_string(S) ->
    case S of
        <<>> -> <<>>;
        _ ->
            Len = byte_size(S),
            Mid = (Len + 1) div 2,
            <<Left:Mid/binary, Right/binary>> = S,
            LeftEncrypted = encrypt_string(Left),
            RightEncrypted = encrypt_string(Right),
            <<RightEncrypted/binary, LeftEncrypted/binary>>
    end.