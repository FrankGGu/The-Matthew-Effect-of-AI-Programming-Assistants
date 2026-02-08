-module(solution).
-export([is_number/1]).

is_number(Str) ->
    case string:to_list(Str) of
        [] -> false;
        Chars -> validate(Chars, false, false, false, false, false)
    end.

validate([], HasDigit, HasDot, HasE, HasSign, HasNum) ->
    HasDigit andalso not HasE andalso not HasSign;
validate([H | T], HasDigit, HasDot, HasE, HasSign, HasNum) ->
    case H of
        $0; $1; $2; $3; $4; $5; $6; $7; $8; $9 ->
            validate(T, true, HasDot, HasE, HasSign, true);
        $. ->
            validate(T, HasDigit, true, HasE, HasSign, HasNum);
        $e; $E ->
            validate_e(T, HasDigit, HasDot, HasSign, HasNum);
        $+; $- ->
            if not HasSign andalso not HasDigit andalso not HasE -> 
                validate(T, HasDigit, HasDot, HasE, true, HasNum);
            true -> validate(T, HasDigit, HasDot, HasE, HasSign, HasNum)
            end;
        _ -> false
    end.

validate_e([], HasDigit, HasDot, HasSign, HasNum) ->
    false;
validate_e([H | T], HasDigit, HasDot, HasSign, HasNum) ->
    case H of
        $0; $1; $2; $3; $4; $5; $6; $7; $8; $9 ->
            validate(T, true, HasDot, true, false, true);
        $+; $- ->
            if not HasSign -> 
                validate_e(T, HasDigit, HasDot, true, HasNum);
            true -> false
            end;
        _ -> false
    end.