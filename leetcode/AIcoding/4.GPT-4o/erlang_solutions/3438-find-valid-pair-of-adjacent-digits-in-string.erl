-module(solution).
-export([find_valid_pair/1]).

find_valid_pair(Str) ->
    find_pair(Str, 1).

find_pair([], _) -> false;
find_pair([_]) -> false;
find_pair([H1, H2 | T], Count) ->
    case is_valid_pair(H1, H2) of
        true -> true;
        false -> find_pair([H2 | T], Count + 1)
    end.

is_valid_pair(A, B) ->
    AbsDiff = abs(A - B),
    AbsDiff =< 1.