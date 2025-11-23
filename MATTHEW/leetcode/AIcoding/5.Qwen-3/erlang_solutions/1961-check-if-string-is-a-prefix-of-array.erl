-module(solution).
-export([is_prefix/2]).

is_prefix(Str, Arr) ->
    is_prefix(Str, Arr, 0).

is_prefix(_, [], _) ->
    true;
is_prefix(Str, [H|T], Index) ->
    case string:substr(Str, Index+1, length(H)) of
        H ->
            is_prefix(Str, T, Index + length(H));
        _ ->
            false
    end.