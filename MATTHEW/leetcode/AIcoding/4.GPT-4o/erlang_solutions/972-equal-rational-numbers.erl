-module(solution).
-export([isRationalEqual/2]).

isRationalEqual(S, T) ->
    parse(S) =:= parse(T).

parse(S) ->
    {Integer, Fraction} = parse_num(S),
    Integer + Fraction.

parse_num(S) ->
    case string:split(S, ".", all) of
        [IntegerPart] ->
            {list_to_integer(IntegerPart), 0};
        [IntegerPart, FractionPart] ->
            {list_to_integer(IntegerPart), parse_fraction(FractionPart)}
    end.

parse_fraction(FractionPart) ->
    case string:split(FractionPart, "(", all) of
        [NonRepeating] ->
            calculate_fraction(NonRepeating, 0);
        [NonRepeating, Repeating] ->
            RepeatingPart = string:trim(trunc(Repeating, 1)),
            NonRepeatingLength = length(NonRepeating),
            RepeatingLength = length(RepeatingPart),
            calculate_fraction(NonRepeating, RepeatingLength + NonRepeatingLength)
    end.

calculate_fraction(Part, RepeatLength) ->
    L = length(Part),
    NonRepeat = list_to_integer(Part),
    if
        RepeatLength =:= 0 ->
            0;
        true ->
            NonRepeat * (10#(L)) + NonRepeat * (10#(RepeatLength) - 1) / (10#(RepeatLength) - 1)
    end.