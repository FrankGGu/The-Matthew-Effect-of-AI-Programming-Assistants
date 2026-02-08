-module(equivalent_rational_numbers).
-export([isRationalEqual/1]).

isRationalEqual(S) ->
    parse(S).

parse(S) ->
    case string:split(S, " ") of
        [A, B] -> compare(parse_fraction(A), parse_fraction(B));
        _ -> false
    end.

parse_fraction(S) ->
    case string:split(S, "/") of
        [N, D] -> {list_to_integer(N), list_to_integer(D)};
        _ -> parse_repeating(S)
    end.

parse_repeating(S) ->
    case string:split(S, "(") of
        [IntPart, RepeatingPart] ->
            Repeating = string:sub(RepeatingPart, 1, string:length(RepeatingPart) - 1),
            Int = parse_int(IntPart),
            {Int, Repeating};
        _ -> parse_int(S)
    end.

parse_int(S) ->
    list_to_integer(S).

compare({N1, D1}, {N2, D2}) ->
    N1 * D2 == N2 * D1;
compare({N1, Repeating1}, {N2, Repeating2}) ->
    A = expand_repeating(N1, Repeating1),
    B = expand_repeating(N2, Repeating2),
    A == B.

expand_repeating(N, Repeating) ->
    Integer = integer_to_list(N),
    Length = length(Repeating),
    Decimal = lists:duplicate(Length, hd(Repeating)),
    list_to_float(integer_to_list(N) ++ "." ++ Decimal).