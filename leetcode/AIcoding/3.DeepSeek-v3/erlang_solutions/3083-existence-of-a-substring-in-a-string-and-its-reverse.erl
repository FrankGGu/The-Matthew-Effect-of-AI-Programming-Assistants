-spec is_substring_present(S :: unicode:unicode_binary()) -> boolean().
is_substring_present(S) ->
    case S of
        <<>> -> false;
        <<_>> -> false;
        _ ->
            R = lists:reverse(binary_to_list(S)),
            check_substring(binary_to_list(S), R)
    end.

check_substring([], _) -> false;
check_substring([_], _) -> false;
check_substring([A, B | _], R) ->
    case lists:member([A, B], R) of
        true -> true;
        false -> check_substring(tl([A, B | _]), R)
    end.