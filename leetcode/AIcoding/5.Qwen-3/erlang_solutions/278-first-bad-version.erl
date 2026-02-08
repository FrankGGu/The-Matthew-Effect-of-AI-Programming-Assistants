-module(first_bad_version).
-export([first_bad_version/1]).

first_bad_version(N) ->
    first_bad_version(1, N).

first_bad_version(L, R) when L == R ->
    L;
first_bad_version(L, R) ->
    Mid = (L + R) div 2,
    case is_bad_version(Mid) of
        true ->
            first_bad_version(L, Mid);
        false ->
            first_bad_version(Mid + 1, R)
    end.

is_bad_version(_N) ->
    erlang:error("is_bad_version/1 is not implemented").