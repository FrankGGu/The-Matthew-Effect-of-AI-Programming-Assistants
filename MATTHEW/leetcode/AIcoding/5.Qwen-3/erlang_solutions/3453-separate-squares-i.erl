-module(solution).
-export([has_square/1]).

has_square([]) -> false;
has_square([H|T]) ->
    lists:member(H*H, T) orelse has_square(T).