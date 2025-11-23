-module(complex_number_multiplication).
-export([complexNumberMultiply/1]).

complexNumberMultiply([A, B]) ->
  {Ar, Ai} = parseComplex(A),
  {Br, Bi} = parseComplex(B),
  Cr = Ar * Br - Ai * Bi,
  Ci = Ar * Bi + Ai * Br,
  list_to_binary(integer_to_list(Cr) ++ "+" ++ integer_to_list(Ci) ++ "i").

parseComplex(Complex) ->
  [Real, Imag] = binary:split(list_to_binary(Complex), "+", [global]),
  {binary_to_integer(Real), binary_to_integer(binary:part(Imag, 0, binary:length(Imag) - 1))}.