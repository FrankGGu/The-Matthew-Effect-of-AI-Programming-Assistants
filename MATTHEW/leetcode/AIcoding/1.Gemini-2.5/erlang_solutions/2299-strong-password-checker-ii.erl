-module(solution).
-export([is_strong_password/1]).

is_strong_password(Password) ->
    Chars = string:to_list(Password),
    Len = length(Chars),

    % 1. It has at least 8 characters.
    if Len < 8 ->
        false;
    true ->
        % 2. It contains at least one lowercase letter.
        HasLower = lists:any(fun erlang:is_lower/1, Chars),
        if not HasLower ->
            false;
        true ->
            % 3. It contains at least one uppercase letter.
            HasUpper = lists:any(fun erlang:is_upper/1, Chars),
            if not HasUpper ->
                false;
            true ->
                % 4. It contains at least one digit.
                HasDigit = lists:any(fun erlang:is_digit/1, Chars),
                if not HasDigit ->
                    false;
                true ->
                    % 5. It contains at least one special character.
                    SpecialChars = string:to_list("!@#$%^&*()-+"),
                    HasSpecial = lists:any(fun(C) -> lists:member(C, SpecialChars) end, Chars),
                    if not HasSpecial ->
                        false;
                    true ->
                        % 6. It does not contain two identical adjacent characters.
                        HasAdjacentSame = check_adjacent_same(Chars),
                        if HasAdjacentSame ->
                            false;
                        true ->
                            true
                        end
                    end
                end
            end
        end
    end.

check_adjacent_same([]) -> false;
check_adjacent_same([_]) -> false;
check_adjacent_same([H1, H2 | T]) ->
    if H1 == H2 -> true;
       true -> check_adjacent_same([H2 | T])
    end.