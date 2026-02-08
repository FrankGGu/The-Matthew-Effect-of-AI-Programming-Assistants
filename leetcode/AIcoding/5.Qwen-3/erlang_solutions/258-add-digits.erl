-module(add_digits).
-export([add_digits/1]).

add_digits(N) when is_integer(N) ->
    case N of
        0 -> 0;
        _ ->
            case N rem 9 of
                0 -> 9;
                R -> R
            end
    end.