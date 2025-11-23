-module(solution).
-export([is_number/1]).

is_number(S) ->
    Trimmed = string:trim(S),
    case Trimmed of
        [] -> false;
        _ -> check_number(Trimmed, initial, false, false, false)
    end.

check_number([], State, HasDigit, HasDot, HasE) ->
    % A valid number must have at least one digit.
    % It cannot end in 'initial' state (e.g., "+", "-").
    % It cannot end in 'e_seen' (e.g., "1e").
    % It cannot end in 'e_sign_seen' (e.g., "1e+").
    % It can end in 'digit_seen' (e.g., "123", "1.23", ".1").
    % It can end in 'dot_seen' if there were digits before it (e.g., "1.").
    % It can end in 'e_digit_seen' (e.g., "1e23", "1.2e+3").
    HasDigit and (State == digit_seen orelse State == dot_seen orelse State == e_digit_seen);
check_number([C|Rest], State, HasDigit, HasDot, HasE) ->
    case C of
        $0 | $1 | $2 | $3 | $4 | $5 | $6 | $7 | $8 | $9 ->
            NewHasDigit = true,
            case State of
                initial ->
                    check_number(Rest, digit_seen, NewHasDigit, HasDot, HasE);
                digit_seen ->
                    check_number(Rest, digit_seen, NewHasDigit, HasDot, HasE);
                dot_seen -> % Digit after a dot
                    check_number(Rest, digit_seen, NewHasDigit, HasDot, HasE);
                e_seen -> % Digit after 'e'
                    check_number(Rest, e_digit_seen, NewHasDigit, HasDot, HasE);
                e_sign_seen -> % Digit after 'e' and sign
                    check_number(Rest, e_digit_seen, NewHasDigit, HasDot, HasE);
                e_digit_seen -> % More digits after 'e' and digit
                    check_number(Rest, e_digit_seen, NewHasDigit, HasDot, HasE);
                _ -> false % Should not happen with valid transitions
            end;
        $. ->
            case HasDot orelse HasE of
                true -> false; % Already seen a dot or 'e', cannot see another dot.
                false ->
                    NewHasDot = true,
                    check_number(Rest, dot_seen, HasDigit, NewHasDot, HasE)
            end;
        $e | $E ->
            case HasE orelse not HasDigit of
                true -> false; % Already seen 'e', or no digits before 'e'.
                false ->
                    NewHasE = true,
                    check_number(Rest, e_seen, HasDigit, HasDot, NewHasE)
            end;
        $+ | $- ->
            case State of
                initial -> % Sign at the beginning
                    check_number(Rest, initial, HasDigit, HasDot, HasE);
                e_seen -> % Sign after 'e'
                    check_number(Rest, e_sign_seen, HasDigit, HasDot, HasE);
                _ -> false % Sign in any other position is invalid
            end;
        _ -> false % Any other character is invalid
    end.