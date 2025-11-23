-module(solution).
-export([sum_encrypted_integers/1]).

sum_encrypted_integers(Encrypted) ->
    lists:sum(lists:map(fun(X) -> list_to_integer(X) end, Encrypted)).