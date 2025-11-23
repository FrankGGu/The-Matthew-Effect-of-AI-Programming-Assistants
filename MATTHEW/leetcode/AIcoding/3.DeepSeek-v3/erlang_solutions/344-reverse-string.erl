-spec reverse_string(S :: unicode:unicode_binary()) -> unicode:unicode_binary().
reverse_string(S) ->
    list_to_binary(lists:reverse(binary_to_list(S))).