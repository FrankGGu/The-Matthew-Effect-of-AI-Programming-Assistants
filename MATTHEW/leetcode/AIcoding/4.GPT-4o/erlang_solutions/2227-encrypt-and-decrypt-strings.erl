-module(solution).
-export([encrypt/2, decrypt/2]).

encrypt(Str, Key) ->
    lists:map(fun(C) -> integer_to_list(((list_to_integer(C) + Key) rem 256)) end, string:to_list(Str)).

decrypt(Str, Key) ->
    lists:map(fun(C) -> integer_to_list(((list_to_integer(C) - Key + 256) rem 256)) end, string:to_list(Str)).