-spec strong_password_checker_ii(Password :: unicode:unicode_binary()) -> boolean().
strong_password_checker_ii(Password) ->
    case byte_size(Password) >= 8 of
        false -> false;
        true ->
            HasLower = lists:any(fun(C) -> C >= $a andalso C =< $z end, binary_to_list(Password)),
            HasUpper = lists:any(fun(C) -> C >= $A andalso C =< $Z end, binary_to_list(Password)),
            HasDigit = lists:any(fun(C) -> C >= $0 andalso C =< $9 end, binary_to_list(Password)),
            HasSpecial = lists:any(fun(C) -> lists:member(C, "!@#$%^&*()-+") end, binary_to_list(Password)),
            NoAdjacent = check_adjacent(Password),
            HasLower andalso HasUpper andalso HasDigit andalso HasSpecial andalso NoAdjacent
    end.

check_adjacent(Password) ->
    check_adjacent(binary_to_list(Password), none).

check_adjacent([], _) -> true;
check_adjacent([C | Rest], C) -> false;
check_adjacent([C | Rest], _) -> check_adjacent(Rest, C).