-module(solution).
-export([multiply/2]).

multiply(Num1Str, Num2Str) ->
    Int1 = list_to_integer(Num1Str),
    Int2 = list_to_integer(Num2Str),
    Product = Int1 * Int2,
    integer_to_list(Product).