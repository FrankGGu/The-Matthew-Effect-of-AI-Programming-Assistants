-spec greatest_letter(S :: unicode:unicode_binary()) -> unicode:unicode_binary().
greatest_letter(S) ->
    Chars = unicode:characters_to_list(S),
    Upper = sets:from_list([C || C <- Chars, C >= $A, C =< $Z]),
    Lower = sets:from_list([C || C <- Chars, C >= $a, C =< $z]),
    Common = sets:to_list(sets:intersection(Upper, sets:from_list([C - 32 || C <- sets:to_list(Lower)])),

    case Common of
        [] -> <<>>;
        _ -> <<lists:max(Common)>>
    end.