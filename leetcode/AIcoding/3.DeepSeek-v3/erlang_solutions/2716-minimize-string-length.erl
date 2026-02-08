-spec minimized_string_length(S :: unicode:unicode_binary()) -> integer().
minimized_string_length(S) ->
    length(sets:to_list(sets:from_list(binary_to_list(S)))).