-module(reverse_string).
-export([reverse_string/1]).

reverse_string(Str) ->
    lists:reverse(Str).