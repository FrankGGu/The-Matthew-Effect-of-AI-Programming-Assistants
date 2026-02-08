-module(solution).
-export([nth_ugly_number/3]).

nth_ugly_number(N, A, B) ->
    ugly_number(N, A, B, 1, 0).

ugly_number(0, _, _, Current, Count) ->
    Current;
ugly_number(N, A, B, Current, Count) ->
    case is_ugly(Current, A, B) of
        true ->
            ugly_number(N - 1, A, B, Current + 1, Count + 1);
        false ->
            ugly_number(N, A, B, Current + 1, Count)
    end.

is_ugly(X, A, B) ->
    (X rem A =:= 0 orelse X rem B =:= 0).