-module(equal_rational_numbers).
-export([is_rational_equal/1]).

is_rational_equal(S) ->
    [S1, S2] = string:split(S, ",", all),
    F1 = to_float(S1),
    F2 = to_float(S2),
    abs(F1 - F2) < 1e-9.

to_float(S) ->
    case string:split(S, "(", all) of
        [NonRepeating, ")"] ->
            case string:split(NonRepeating, ".", all) of
                [Integer] ->
                    to_float_helper(Integer, "");
                [Integer, Repeating] ->
                    to_float_helper(Integer, Repeating);
                _ ->
                    0.0
            end;
        [NonRepeating] ->
            case string:split(NonRepeating, ".", all) of
                [Integer] ->
                    list_to_float(string:to_list(Integer));
                [Integer, Fraction] ->
                    list_to_float(string:to_list(Integer ++ "." ++ Fraction));
                _ ->
                    0.0
            end;
        _ ->
            0.0
    end.

to_float_helper(Integer, Repeating) ->
    case Repeating of
        "" ->
            list_to_float(string:to_list(Integer));
        _ ->
            case string:split(Integer, ".", all) of
                [IntPart] ->
                    Int = list_to_float(string:to_list(IntPart)),
                    FractionalPart = repeating_to_fractional(Repeating),
                    Int + FractionalPart;
                [IntPart, FractionalPart] ->
                    Int = list_to_float(string:to_list(IntPart ++ "." ++ FractionalPart)),
                    RepeatingPart = repeating_to_fractional(Repeating),
                    Int + RepeatingPart;
                _ ->
                    0.0
            end
    end.

repeating_to_fractional(Repeating) ->
    Len = length(Repeating),
    Fraction = list_to_float(string:to_list(Repeating)),
    Fraction / (math:pow(10, Len) - 1) / math:pow(10, Len).