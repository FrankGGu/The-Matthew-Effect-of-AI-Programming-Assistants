-spec remove_palindrome_sub(S :: unicode:unicode_binary()) -> integer().
remove_palindrome_sub(S) ->
    case S =:= unicode:characters_to_binary(lists:reverse(binary_to_list(S))) of
        true -> 1;
        false -> 2
    end.