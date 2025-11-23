-module(valid_number).
-export([is_valid_number/1]).

is_valid_number(S) ->
    is_valid_number(S, false, false, false, false).

is_valid_number([], _, _, _, _) ->
    true;
is_valid_number([H | T], has_digit, has_e, has_sign, has_dot) ->
    case H of
        $0 -> is_valid_number(T, true, has_e, has_sign, has_dot);
        $1 -> is_valid_number(T, true, has_e, has_sign, has_dot);
        $2 -> is_valid_number(T, true, has_e, has_sign, has_dot);
        $3 -> is_valid_number(T, true, has_e, has_sign, has_dot);
        $4 -> is_valid_number(T, true, has_e, has_sign, has_dot);
        $5 -> is_valid_number(T, true, has_e, has_sign, has_dot);
        $6 -> is_valid_number(T, true, has_e, has_sign, has_dot);
        $7 -> is_valid_number(T, true, has_e, has_sign, has_dot);
        $8 -> is_valid_number(T, true, has_e, has_sign, has_dot);
        $9 -> is_valid_number(T, true, has_e, has_sign, has_dot);
        $e -> 
            if
                has_e -> false;
                true -> is_valid_number(T, false, true, false, false)
            end;
        $+ -> 
            if
                has_sign -> false;
                true -> is_valid_number(T, has_digit, has_e, true, has_dot)
            end;
        $- -> 
            if
                has_sign -> false;
                true -> is_valid_number(T, has_digit, has_e, true, has_dot)
            end;
        $. -> 
            if
                has_dot -> false;
                true -> is_valid_number(T, has_digit, has_e, has_sign, true)
            end;
        _ -> false
    end;
is_valid_number([H | T], has_digit, has_e, has_sign, has_dot) ->
    case H of
        $0 -> is_valid_number(T, true, has_e, has_sign, has_dot);
        $1 -> is_valid_number(T, true, has_e, has_sign, has_dot);
        $2 -> is_valid_number(T, true, has_e, has_sign, has_dot);
        $3 -> is_valid_number(T, true, has_e, has_sign, has_dot);
        $4 -> is_valid_number(T, true, has_e, has_sign, has_dot);
        $5 -> is_valid_number(T, true, has_e, has_sign, has_dot);
        $6 -> is_valid_number(T, true, has_e, has_sign, has_dot);
        $7 -> is_valid_number(T, true, has_e, has_sign, has_dot);
        $8 -> is_valid_number(T, true, has_e, has_sign, has_dot);
        $9 -> is_valid_number(T, true, has_e, has_sign, has_dot);
        $e -> 
            if
                has_e -> false;
                true -> is_valid_number(T, false, true, false, false)
            end;
        $+ -> 
            if
                has_sign -> false;
                true -> is_valid_number(T, has_digit, has_e, true, has_dot)
            end;
        $- -> 
            if
                has_sign -> false;
                true -> is_valid_number(T, has_digit, has_e, true, has_dot)
            end;
        $. -> 
            if
                has_dot -> false;
                true -> is_valid_number(T, has_digit, has_e, has_sign, true)
            end;
        _ -> false
    end;
is_valid_number([H | T], _, has_e, _, _) ->
    case H of
        $0 -> is_valid_number(T, true, has_e, false, false);
        $1 -> is_valid_number(T, true, has_e, false, false);
        $2 -> is_valid_number(T, true, has_e, false, false);
        $3 -> is_valid_number(T, true, has_e, false, false);
        $4 -> is_valid_number(T, true, has_e, false, false);
        $5 -> is_valid_number(T, true, has_e, false, false);
        $6 -> is_valid_number(T, true, has_e, false, false);
        $7 -> is_valid_number(T, true, has_e, false, false);
        $8 -> is_valid_number(T, true, has_e, false, false);
        $9 -> is_valid_number(T, true, has_e, false, false);
        $+ -> is_valid_number(T, false, has_e, true, false);
        $- -> is_valid_number(T, false, has_e, true, false);
        _ -> false
    end;
is_valid_number([H | T], _, _, _, _) ->
    case H of
        $0 -> is_valid_number(T, true, false, false, false);
        $1 -> is_valid_number(T, true, false, false, false);
        $2 -> is_valid_number(T, true, false, false, false);
        $3 -> is_valid_number(T, true, false, false, false);
        $4 -> is_valid_number(T, true, false, false, false);
        $5 -> is_valid_number(T, true, false, false, false);
        $6 -> is_valid_number(T, true, false, false, false);
        $7 -> is_valid_number(T, true, false, false, false);
        $8 -> is_valid_number(T, true, false, false, false);
        $9 -> is_valid_number(T, true, false, false, false);
        $e -> is_valid_number(T, false, true, false, false);
        $+ -> is_valid_number(T, false, false, true, false);
        $- -> is_valid_number(T, false, false, true, false);
        $. -> is_valid_number(T, false, false, false, true);
        _ -> false
    end.