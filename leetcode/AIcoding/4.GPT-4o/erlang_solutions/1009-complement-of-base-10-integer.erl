-module(solution).
-export([bitwiseComplement/1]).

bitwiseComplement(N) ->
    B = integer_to_binary(N, 2),
    Complement = lists:map(fun(X) -> if X =:= $0 -> $1; true -> $0 end end, B),
    binary_to_integer(Complement, 2).