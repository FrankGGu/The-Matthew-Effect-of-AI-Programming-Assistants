-spec path_encryption(Path :: unicode:unicode_binary()) -> unicode:unicode_binary().
path_encryption(Path) ->
    binary:replace(Path, <<".">>, <<" ">>, [global]).