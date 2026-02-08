-spec find_original_string(Encoded :: unicode:unicode_binary()) -> unicode:unicode_binary().
find_original_string(Encoded) ->
    << <<Char>> || <<Char, _>> <= Encoded >>.