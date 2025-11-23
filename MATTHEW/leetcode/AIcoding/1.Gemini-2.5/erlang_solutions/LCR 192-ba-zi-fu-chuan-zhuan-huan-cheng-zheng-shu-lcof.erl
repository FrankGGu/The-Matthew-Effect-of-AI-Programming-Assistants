-module(solution).
-export([myAtoi/1]).

-define(MAX_INT, 2147483647).
-define(MIN_INT, -2147483648).

myAtoi(S) ->
    StrippedS = string:strip(S, leading, $\s),
    parse_signed_integer(StrippedS, 0, 1).

parse_signed_integer([], Acc, Sign) ->
    Acc * Sign;
parse_signed_integer([$-|T], Acc, _Sign) ->
    parse_digits(T, Acc, -1);
parse_signed_integer([$+|T], Acc, _Sign) ->
    parse_digits(T, Acc, 1);
parse_signed_integer(S, Acc, Sign) ->
    parse_digits(S, Acc, Sign).

parse_digits([], Acc, Sign) ->
    Acc * Sign;
parse_digits([H|T], Acc, Sign) when H >= $0, H <= $9 ->
    Digit = H - $0,
    case Sign of
        1 -> % Positive
            if
                Acc > ?MAX_INT div 10 -> ?MAX_INT;
                Acc == ?MAX_INT div 10 andalso Digit > 7 -> ?MAX_INT;
                true -> parse_digits(T, Acc * 10 + Digit, Sign)
            end;
        -1 -> % Negative
            if
                Acc > ?MAX_INT div 10 -> ?MIN_INT;
                Acc == ?MAX_INT div 10 andalso Digit > 8 -> ?MIN_INT;
                true -> parse_digits(T, Acc * 10 + Digit, Sign)
            end
    end;
parse_digits(_OtherChars, Acc, Sign) ->
    Acc * Sign.