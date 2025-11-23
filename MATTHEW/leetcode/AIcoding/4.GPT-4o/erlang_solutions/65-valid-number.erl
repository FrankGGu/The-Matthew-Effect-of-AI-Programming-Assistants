%% -spec is_number(S :: unicode:unicode_binary()) -> boolean().
is_number(S) ->
    case re:run(S, "^[+-]?((\\d+\\.\\d*)|(\\.\\d+)|(\\d+))([eE][+-]?\\d+)?$", [unicode, caseless]) of
        {match, _} -> true;
        _ -> false
    end.
