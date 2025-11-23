-spec is_valid(S :: unicode:unicode_binary()) -> boolean().
is_valid(S) ->
    case re:run(S, "^[a-zA-Z]+$|^[0-9]+$|^[a-zA-Z0-9]+$", [{capture, none}]) of
        match -> true;
        nomatch -> false
    end.