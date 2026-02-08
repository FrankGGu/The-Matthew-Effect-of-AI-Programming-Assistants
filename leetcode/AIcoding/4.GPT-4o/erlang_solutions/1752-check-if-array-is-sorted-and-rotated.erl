-module(solution).
-export([check_rotated_sorted/1]).

check_rotated_sorted(Array) ->
    N = length(Array),
    if
        N == 0 -> true;
        N == 1 -> true;
        true ->
            {Min, _} = lists:minmax(Array),
            MinIndex = lists:find(fun(X) -> X == Min end, Array),
            Rotated = lists:take(N - MinIndex, Array) ++ lists:take(MinIndex, Array),
            is_sorted(Rotated)
    end.

is_sorted([]) -> true;
is_sorted([_]) -> true;
is_sorted([H1, H2 | T]) -> H1 =< H2 andalso is_sorted([H2 | T]).