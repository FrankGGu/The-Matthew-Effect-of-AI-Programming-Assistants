-module(dynamic_password).
-export([is_digit/1, is_upper/1, is_lower/1, is_valid/1]).

is_digit(C) when C >= $0, C =< $9 -> true;
is_digit(_) -> false.

is_upper(C) when C >= $A, C =< $Z -> true;
is_upper(_) -> false.

is_lower(C) when C >= $a, C =< $z -> true;
is_lower(_) -> false.

is_valid(Pass) ->
    Length = length(Pass),
    if
        Length < 8 -> false;
        true ->
            {HasDigit, HasUpper, HasLower} = lists:foldl(
                fun(C, {D, U, L}) ->
                    D1 = D orelse is_digit(C),
                    U1 = U orelse is_upper(C),
                    L1 = L orelse is_lower(C),
                    {D1, U1, L1}
                end,
                {false, false, false},
                Pass
            ),
            HasDigit andalso HasUpper andalso HasLower
    end.