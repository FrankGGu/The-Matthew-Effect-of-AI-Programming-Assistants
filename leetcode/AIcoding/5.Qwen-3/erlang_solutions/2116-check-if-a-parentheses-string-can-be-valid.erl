-module(solution).
-export([isValid/1]).

isValid(S) ->
    validate(S, 0).

validate([], 0) -> true;
validate([], _) -> false;
validate([$( | T], N) -> validate(T, N + 1);
validate([$) | T], N) when N > 0 -> validate(T, N - 1);
validate([_ | T], N) -> validate(T, N).