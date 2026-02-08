-module(solution).
-export([complex_number_multiply/2]).

%% Multiply two complex numbers represented as strings
-spec complex_number_multiply(Num1 :: unicode:unicode_binary(), Num2 :: unicode:unicode_binary()) -> unicode:unicode_binary().
complex_number_multiply(Num1, Num2) ->
    {Real1, Imag1} = parse_complex(Num1),
    {Real2, Imag2} = parse_complex(Num2),
    RealResult = Real1 * Real2 - Imag1 * Imag2,
    ImagResult = Real1 * Imag2 + Imag1 * Real2,
    io_lib:format("~w+~wi", [RealResult, ImagResult]).

%% Parse a complex number in the form of "a+bi" or "a-bi"
-spec parse_complex(unicode:unicode_binary()) -> {integer(), integer()}.
parse_complex(Num) ->
    {Real, Imaginary} = 
        case lists:splitwith(fun(C) -> C /= $+ end, Num) of
            {RealPart, ["+", ImagPart]} -> {list_to_integer(RealPart), list_to_integer(ImagPart)};
            {RealPart, ["-", ImagPart]} -> {list_to_integer(RealPart), -list_to_integer(ImagPart)}
        end,
    {Real, Imaginary}.
