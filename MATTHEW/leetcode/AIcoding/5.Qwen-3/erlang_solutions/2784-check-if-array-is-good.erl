-module(solution).
-export([is_good/1]).

is_good(Arr) ->
    N = length(Arr),
    is_good(Arr, N, 1).

is_good([], _, _) ->
    true;
is_good([H | T], N, I) ->
    case H of
        I -> is_good(T, N, I + 1);
        _ -> false
    end.