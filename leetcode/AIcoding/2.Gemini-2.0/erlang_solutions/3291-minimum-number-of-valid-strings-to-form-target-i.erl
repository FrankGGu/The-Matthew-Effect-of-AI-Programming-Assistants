-module(min_valid_strings1).
-export([min_extra_char/2]).

min_extra_char(S, Target) ->
    min_extra_char(S, Target, 0, 0, 0).

min_extra_char(_S, [], SIndex, _TargetIndex, Extra) ->
    Extra + length(_S) - SIndex;
min_extra_char([], _Target, _SIndex, TargetIndex, Extra) ->
    Extra + length(_Target) - TargetIndex;
min_extra_char([], [], _SIndex, _TargetIndex, Extra) ->
    Extra;
min_extra_char(S, Target, SIndex, TargetIndex, Extra) ->
    case lists:nth(1, string:substr(S, SIndex + 1, 1)) == lists:nth(1, string:substr(Target, TargetIndex + 1, 1)) of
        true ->
            min_extra_char(S, Target, SIndex + 1, TargetIndex + 1, Extra);
        false ->
            min(min_extra_char(S, Target, SIndex + 1, TargetIndex, Extra + 1),
                min_extra_char(S, Target, SIndex, TargetIndex + 1, Extra + 1))
    end.

min(A, B) ->
    if A < B -> A; true -> B end.