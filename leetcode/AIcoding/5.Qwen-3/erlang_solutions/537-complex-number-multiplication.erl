-module(solution).
-export([complex_number_multiply/2]).

complex_number_multiply(A, B) ->
    [RealA, ImgA] = parse_complex(A),
    [RealB, ImgB] = parse_complex(B),
    Real = RealA * RealB - ImgA * ImgB,
    Img = RealA * ImgB + ImgA * RealB,
    io_lib:format("~w+~wi", [Real, Img]).

parse_complex(Str) ->
    [RealStr, ImgStr] = string:split(Str, "+"),
    Real = list_to_integer(RealStr),
    Img = list_to_integer(string:sub_string(ImgStr, 1, length(ImgStr) - 1)),
    [Real, Img].