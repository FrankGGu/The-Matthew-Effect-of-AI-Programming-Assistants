-module(solution).
-export([fraction_addition/1]).

-spec fraction_addition(Expression :: unicode:unicode_binary()) -> unicode:unicode_binary().

fraction_addition(Expression) ->
    Str = binary_to_list(Expression),
    Tokens = tokenize(Str),
    Fractions = parse_fractions(Tokens),
    Sum = reduce_fractions(Fractions),
    format_result(Sum).

tokenize("") -> [];
tokenize("+" ++ Rest) -> ["+"] ++ tokenize(Rest);
tokenize("-" ++ Rest) -> ["-"] ++ tokenize(Rest);
tokenize("/" ++ Rest) -> ["/"] ++ tokenize(Rest);
tokenize([C | Rest]) when C >= $0, C =< $9 ->
    {Num, Rest2} = collect_digits([C], Rest),
    [list_to_integer(lists:reverse(Num))] ++ tokenize(Rest2);
tokenize([C | Rest]) -> tokenize(Rest).

collect_digits(Acc, [C | R]) when C >= $0, C =< $9 ->
    collect_digits([C | Acc], R);
collect_digits(Acc, Rest) ->
    {lists:reverse(Acc), Rest}.

parse_fractions(Tokens) ->
    parse_fractions(Tokens, []).

parse_fractions([], Acc) -> lists:reverse(Acc);
parse_fractions(["+" | Rest], Acc) -> parse_fraction_sign(pos, Rest, Acc);
parse_fractions(["-" | Rest], Acc) -> parse_fraction_sign(neg, Rest, Acc);
parse_fractions([Numerator | "/" | Denominator | Rest], Acc) ->
    parse_fractions(Rest, [{pos, Numerator, Denominator} | Acc]);
parse_fractions([Token | Rest], Acc) when is_integer(Token) ->
    case Rest of
        ["/" | Rest2] -> parse_fractions([Token | Rest2], Acc);
        _ -> parse_fractions(Rest, [{pos, Token, 1} | Acc])
    end.

parse_fraction_sign(Sign, [Numerator | "/" | Denominator | Rest], Acc) ->
    parse_fractions(Rest, [{{Sign, Numerator, Denominator}} | Acc]);
parse_fraction_sign(Sign, [Token | Rest], Acc) when is_integer(Token) ->
    case Rest of
        ["/" | Rest2] ->
            parse_fractions([Token | Rest2], Acc);
        _ ->
            parse_fractions(Rest, [{{Sign, Token, 1}} | Acc])
    end.

reduce_fractions([]) -> "0/1";
reduce_fractions([Frac | Fracs]) ->
    lists:foldl(fun(F, Acc) ->
        add_fractions(Acc, F)
    end, Frac, Fracs).

add_fractions({Sign1, Num1, Den1}, {Sign2, Num2, Den2}) ->
    SignNum1 = if Sign1 == neg -> -Num1; true -> Num1 end,
    SignNum2 = if Sign2 == neg -> -Num2; true -> Num2 end,
    NewNum = SignNum1 * Den2 + SignNum2 * Den1,
    NewDen = Den1 * Den2,
    reduce_and_format(NewNum, NewDen).

reduce_and_format(Num, Den) when Den < 0 ->
    reduce_and_format(-Num, -Den);
reduce_and_format(Num, Den) when Num == 0 ->
    {_, _, Gcd} = gcd(Num, Den),
    io_lib:format("0/~B", [Den div Gcd]);
reduce_and_format(Num, Den) ->
    {GcdSign, AbsNum, AbsDen} = if Num < 0 ->
        {-1, -Num, Den};
        true ->
            {1, Num, Den}
    end,
    Gcd = gcd(AbsNum, AbsDen),
    ReducedNum = AbsNum div Gcd,
    ReducedDen = AbsDen div Gcd,
    FinalNum = if GcdSign < 0 -> -ReducedNum; true -> ReducedNum end,
    io_lib:format("~B/~B", [FinalNum, ReducedDen]).

gcd(A, B) when A < 0 -> gcd(-A, B);
gcd(A, B) when B == 0 -> {A, A, B};
gcd(A, B) -> gcd(B, A rem B).

format_result(Result) when is_list(Result) ->
    list_to_binary(Result).