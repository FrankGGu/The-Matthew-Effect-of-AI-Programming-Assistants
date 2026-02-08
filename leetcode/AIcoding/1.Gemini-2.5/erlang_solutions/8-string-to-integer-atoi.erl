-module(solution).
-export([my_atoi/1]).

-define(MAX_INT, 2147483647).
-define(MIN_INT, -2147483648).

my_atoi(S) ->
    Chars = string:to_list(S),
    {Sign, RemainingChars} = skip_whitespace_and_sign(Chars),
    Num = parse_digits(RemainingChars, 0),
    Result = Sign * Num,
    clamp(Result).

skip_whitespace_and_sign(Chars) ->
    Trimmed = skip_whitespace(Chars),
    case Trimmed of
        [$- | T] -> {-1, T};
        [$+ | T] -> {1, T};
        _        -> {1, Trimmed}
    end.

skip_whitespace([$ | T]) -> skip_whitespace(T);
skip_whitespace(Other) -> Other.

parse_digits([C | T], Acc) when C >= $0, C <= $9 ->
    Digit = C - $0,
    NewAcc = Acc * 10 + Digit,
    parse_digits(T, NewAcc);
parse_digits(_, Acc) ->
    Acc.

clamp(N) when N > ?MAX_INT -> ?MAX_INT;
clamp(N) when N < ?MIN_INT -> ?MIN_INT;
clamp(N) -> N.