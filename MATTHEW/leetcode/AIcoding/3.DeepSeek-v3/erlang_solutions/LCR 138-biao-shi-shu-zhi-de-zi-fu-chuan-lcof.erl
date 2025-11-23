-spec is_number(S :: unicode:unicode_binary()) -> boolean().
is_number(S) ->
    case re:run(S, "^\\s*[+-]?(\\d+\\.?\\d*|\\.\\d+)([eE][+-]?\\d+)?\\s*$", [{capture, none}]) of
        match -> true;
        nomatch -> false
    end.