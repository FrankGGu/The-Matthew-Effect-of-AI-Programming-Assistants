-module(solution).
-export([is_rational_equal/2]).

is_rational_equal(S, T) ->
    {A1, B1} = parse(S),
    {A2, B2} = parse(T),
    A1 * B2 == A2 * B1.

parse(S) ->
    {Main, Rest1} = parse_integer(S),
    case Rest1 of
        [] -> {Main, 1};
        [$. | Rest2] ->
            {Decimal, Rest3} = parse_decimal(Rest2, []),
            case Rest3 of
                [] -> {Main * pow(10, length(Decimal)) + list_to_integer(Decimal), pow(10, length(Decimal))};
                [$( | Rest4] ->
                    {Repeat, _} = parse_repeat(Rest4, []),
                    DLen = length(Decimal),
                    RLen = length(Repeat),
                    Numerator = (Main * pow(10, DLen) + list_to_integer(Decimal)) * (pow(10, RLen) - 1) + list_to_integer(Repeat),
                    Denominator = pow(10, DLen) * (pow(10, RLen) - 1),
                    {Numerator, Denominator}
            end
    end.

parse_integer([]) -> {0, []};
parse_integer([C | Rest]) when C >= $0, C =< $9 ->
    {Num, Rest1} = parse_integer(Rest),
    {(C - $0) + Num * 10, Rest1};
parse_integer(S) -> {0, S}.

parse_decimal([], Acc) -> {lists:reverse(Acc), []};
parse_decimal([C | Rest], Acc) when C >= $0, C =< $9 ->
    parse_decimal(Rest, [C | Acc]);
parse_decimal(S, Acc) -> {lists:reverse(Acc), S}.

parse_repeat([$)], Acc) -> {lists:reverse(Acc), []};
parse_repeat([C | Rest], Acc) when C >= $0, C =< $9 ->
    parse_repeat(Rest, [C | Acc]).

pow(_, 0) -> 1;
pow(B, E) -> B * pow(B, E - 1).