-module(solution).
-export([capitalize_title/1]).

capitalize_title([]) -> [];
capitalize_title([H|T]) ->
    [capitalize_char(H)] ++ capitalize_title(T).

capitalize_char(C) when C >= $a, C =< $z -> C - 32;
capitalize_char(C) -> C.