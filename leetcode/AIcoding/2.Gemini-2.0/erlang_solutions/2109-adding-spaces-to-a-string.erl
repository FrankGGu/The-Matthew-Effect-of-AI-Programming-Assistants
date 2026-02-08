-module(adding_spaces).
-export([add_spaces/2]).

add_spaces(S, Spaces) ->
    add_spaces(S, Spaces, []).

add_spaces(_, [], Acc) ->
    lists:reverse(Acc);
add_spaces(S, [H|T], Acc) ->
    {Prefix, Suffix} = lists:split(H, S),
    add_spaces(Suffix, T, Acc ++ [Prefix, " "]).