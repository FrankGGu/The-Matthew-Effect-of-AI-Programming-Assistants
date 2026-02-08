-module(solution).
-export([is_prefix/2]).

is_prefix(Stream, Word) ->
    is_prefix(Stream, Word, 0).

is_prefix([], _) -> true;
is_prefix(_, []) -> false;
is_prefix([H | T], [H | W]) -> is_prefix(T, W);
is_prefix(_, _) -> false.