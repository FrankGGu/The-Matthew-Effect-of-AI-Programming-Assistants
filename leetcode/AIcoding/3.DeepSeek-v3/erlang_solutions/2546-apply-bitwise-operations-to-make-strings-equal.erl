-spec make_strings_equal(S :: unicode:unicode_binary(), T :: unicode:unicode_binary()) -> boolean().
make_strings_equal(S, T) ->
    case {S, T} of
        {S, S} -> true;
        {<<"0">>, <<"1">>} -> false;
        {<<"1">>, <<"0">>} -> false;
        _ ->
            HasOneS = binary:match(S, <<"1">>) =/= nomatch,
            HasOneT = binary:match(T, <<"1">>) =/= nomatch,
            (HasOneS andalso HasOneT) orelse (not HasOneS andalso not HasOneT)
    end.