-module(solution).
-export([min_flips/1]).

min_flips(S) ->
    Len = length(S),
    Flip0 = count_flips(S, $0, 0),
    Flip1 = count_flips(S, $1, 0),
    min(Flip0, Flip1).

count_flips([], _, Count) -> Count;
count_flips([H | T], Expected, Count) ->
    if
        H == Expected -> count_flips(T, $1 - (Expected - $0), Count);
        true -> count_flips(T, $1 - (Expected - $0), Count + 1)
    end.