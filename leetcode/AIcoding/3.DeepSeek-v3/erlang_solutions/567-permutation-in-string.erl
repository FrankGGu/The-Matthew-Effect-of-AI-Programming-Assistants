-spec check_inclusion(S1 :: unicode:unicode_binary(), S2 :: unicode:unicode_binary()) -> boolean().
check_inclusion(S1, S2) ->
    Len1 = byte_size(S1),
    Len2 = byte_size(S2),
    if
        Len1 > Len2 -> false;
        true ->
            Target = lists:sort(binary_to_list(S1)),
            check_window(S2, Target, Len1, Len2)
    end.

check_window(S2, Target, Len1, Len2) ->
    case Len2 >= Len1 of
        false -> false;
        true ->
            Window = lists:sort(binary_to_list(binary:part(S2, 0, Len1))),
            case Window =:= Target of
                true -> true;
                false -> check_window(binary:part(S2, 1, Len2 - 1), Target, Len1, Len2 - 1)
            end
    end.