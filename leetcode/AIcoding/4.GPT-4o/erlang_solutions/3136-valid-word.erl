-module(solution).
-export([is_valid_word/2]).

is_valid_word(W, B) ->
    lists:all(fun(X) -> lists:member(X, B) end, string:to_list(W)).