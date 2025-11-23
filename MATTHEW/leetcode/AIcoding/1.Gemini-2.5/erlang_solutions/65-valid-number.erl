-module(solution).
-export([is_number/1]).

is_number(S) ->
    Chars = string:to_list(S),
    fsm(Chars, 0, false, false). % Chars, State, HasMantissaDigits, HasExponentDigits

fsm([], State, HasMantissaDigits, HasExponentDigits) ->
    % Valid ending states:
    % 2: Integer part (e.g., "123")
    % 4: Decimal part (e.g., "123.45", ".45", "123.")
    % 7: Exponent part (e.g., "1e2", "1.2e3")
    % 8: Trailing spaces (if reached from a valid number state)
    (State == 2 and HasMantissaDigits) or
    (State == 4 and HasMantissaDigits) or
    (State == 7 and HasExponentDigits) or
    (State == 8 and (HasMantissaDigits or HasExponentDigits));
fsm([C|Rest], State, HasMantissaDigits, HasExponentDigits) ->
    case {State, C} of
        % State 0: Initial (leading spaces)
        {0, $\s$} -> fsm(Rest, 0, HasMantissaDigits, HasExponentDigits);
        {0, $+} -> fsm(Rest, 1, HasMantissaDigits, HasExponentDigits);
        {0, $-} -> fsm(Rest, 1, HasMantissaDigits, HasExponentDigits);
        {0, $.} -> fsm(Rest, 3, HasMantissaDigits, HasExponentDigits); % e.g., ".1"
        {0, C} when C >= $0$, C =< $9$ -> fsm(Rest, 2, true, HasExponentDigits); % First digit of mantissa
        {0, _} -> false;

        % State 1: Sign encountered
        {1, $.} -> fsm(Rest, 3, HasMantissaDigits, HasExponentDigits); % e.g., "+.1"
        {1, C} when C >= $0$, C =< $9$ -> fsm(Rest, 2, true, HasExponentDigits); % First digit of mantissa
        {1, _} -> false;

        % State 2: Digit before decimal point (integer part)
        {2, C} when C >= $0$, C =< $9$ -> fsm(Rest, 2, true, HasExponentDigits); % Keep HasMantissaDigits true
        {2, $.} -> fsm(Rest, 4, true, HasExponentDigits); % Keep HasMantissaDigits true
        {2, $e$} -> fsm(Rest, 5, true, HasExponentDigits); % Keep HasMantissaDigits true
        {2, $E$} -> fsm(Rest, 5, true, HasExponentDigits); % Keep HasMantissaDigits true
        {2, $\s$} -> fsm(Rest, 8, true, HasExponentDigits); % Keep HasMantissaDigits true
        {2, _} -> false;

        % State 3: Decimal point, no preceding digits (e.g., ".1")
        {3, C} when C >= $0$, C =< $9$ -> fsm(Rest, 4, true, HasExponentDigits); % First digit of mantissa
        {3, _} -> false; % e.g., ".", "+."

        % State 4: Digit after '.' or '.' after digits (fractional part)
        {4, C} when C >= $0$, C =< $9$ -> fsm(Rest, 4, true, HasExponentDigits); % Keep HasMantissaDigits true
        {4, $e$} -> fsm(Rest, 5, true, HasExponentDigits); % Keep HasMantissaDigits true
        {4, $E$} -> fsm(Rest, 5, true, HasExponentDigits); % Keep HasMantissaDigits true
        {4, $\s$} -> fsm(Rest, 8, true, HasExponentDigits); % Keep HasMantissaDigits true
        {4, _} -> false;

        % State 5: Exponent 'e' or 'E'
        % Must have had mantissa digits before 'e'/'E'
        {5, $+} when HasMantissaDigits -> fsm(Rest, 6, HasMantissaDigits, HasExponentDigits);
        {5, $-} when HasMantissaDigits -> fsm(Rest, 6, HasMantissaDigits, HasExponentDigits);
        {5, C} when C >= $0$, C =< $9$, HasMantissaDigits -> fsm(Rest, 7, HasMantissaDigits, true); % First digit of exponent
        {5, _} -> false; % If no mantissa digits, or invalid char

        % State 6: Sign after 'e'/'E'
        % Must have had mantissa digits before 'e'/'E'
        {6, C} when C >= $0$, C =< $9$, HasMantissaDigits -> fsm(Rest, 7, HasMantissaDigits, true); % First digit of exponent
        {6, _} -> false; % If no mantissa digits, or invalid char

        % State 7: Digit after 'e'/'E'
        % Must have had mantissa digits before 'e'/'E' and exponent digits after 'e'/'E'
        {7, C} when C >= $0$, C =< $9$, HasMantissaDigits, HasExponentDigits -> fsm(Rest, 7, HasMantissaDigits, true); % Keep HasExponentDigits true
        {7, $\s$} when HasMantissaDigits, HasExponentDigits -> fsm(Rest, 8, HasMantissaDigits, true); % Keep HasExponentDigits true
        {7, _} -> false;

        % State 8: Trailing spaces
        {8, $\s$} -> fsm(Rest, 8, HasMantissaDigits, HasExponentDigits);
        {8, _} -> false
    end.