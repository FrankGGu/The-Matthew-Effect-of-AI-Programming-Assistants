-spec complex_number_multiply(num1 :: unicode:unicode_binary(), num2 :: unicode:unicode_binary()) -> unicode:unicode_binary().
complex_number_multiply(Num1, Num2) ->
    [A, B] = parse_complex(Num1),
    [C, D] = parse_complex(Num2),
    Real = A * C - B * D,
    Imaginary = A * D + B * C,
    lists:flatten(io_lib:format("~b+~bi", [Real, Imaginary])).

parse_complex(Complex) ->
    [Real, Imaginary] = binary:split(Complex, <<"+">>),
    R = binary_to_integer(Real),
    I = binary_to_integer(binary:part(Imaginary, 0, byte_size(Imaginary) - 1)),
    [R, I].