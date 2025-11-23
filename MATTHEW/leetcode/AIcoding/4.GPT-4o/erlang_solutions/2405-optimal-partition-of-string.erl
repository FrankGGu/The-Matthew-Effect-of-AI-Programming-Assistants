-module(solution).
-export([partition/1]).

partition(S) ->
    partition(S, 0, #{}, 0).

partition([], Count, _, Count).
partition([H | T], Count, Seen, Result) ->
    case maps:is_key(H, Seen) of
        true ->
            partition(T, Count + 1, #{H => true}, Result);
        false ->
            partition(T, Count, maps:put(H, true, Seen), Result)
    end.