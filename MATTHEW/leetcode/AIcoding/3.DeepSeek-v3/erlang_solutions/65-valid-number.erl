is_number(S) ->
    case string:trim(S) of
        "" -> false;
        Trimmed ->
            case re:run(Trimmed, "^[+-]?((\\d+\\.?\\d*)|(\\.\\d+))([eE][+-]?\\d+)?$", [{capture, none}]) of
                match -> true;
                nomatch -> false
            end
    end.