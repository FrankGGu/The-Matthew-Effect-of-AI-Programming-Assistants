-spec dynamic_password(Password :: unicode:unicode_binary(), Target :: integer()) -> unicode:unicode_binary().
dynamic_password(Password, Target) ->
    Size = byte_size(Password),
    <<Left:Target/binary, Right/binary>> = Password,
    <<Right/binary, Left/binary>>.