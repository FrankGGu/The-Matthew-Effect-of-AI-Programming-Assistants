-module(solution).
-export([complex_number_multiply/2]).

complex_number_multiply(Num1, Num2) ->
    {A, B} = parse_complex(Num1),
    {C, D} = parse_complex(Num2),

    RealPart = A*C - B*D,
    ImaginaryPart = A*D + B*C,

    io_lib:format("~w+~wi", [RealPart, ImaginaryPart]).

parse_complex(NumStr) ->
    PlusIdx = string:str(NumStr, "+"),
    RealStr = string:substr(NumStr, 1, PlusIdx - 1),
    ImaginaryStrLen = length(NumStr) - PlusIdx - 1,
    ImaginaryStr = string:substr(NumStr, PlusIdx + 1, ImaginaryStrLen),

    Real = list_to_integer(RealStr),
    Imaginary = list_to_integer(ImaginaryStr),
    {Real, Imaginary}.