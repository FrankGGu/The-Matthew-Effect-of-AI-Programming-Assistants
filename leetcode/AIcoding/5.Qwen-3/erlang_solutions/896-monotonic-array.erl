-module(monotonic_array).
-export([is_monotonic/1]).

is_monotonic(A) ->
    is_monotonic(A, 0, length(A) - 1).

is_monotonic(_, _, N) when N < 0 ->
    true;
is_monotonic(A, I, J) ->
    if
        I == J -> true;
        true ->
            case A of
                [H | T] ->
                    if
                        H >= element(I + 1, A) -> is_monotonic(A, I + 1, J);
                        H =< element(I + 1, A) -> is_monotonic(A, I + 1, J);
                        true -> false
                    end
            end.

element(Index, List) ->
    lists:nth(Index + 1, List).