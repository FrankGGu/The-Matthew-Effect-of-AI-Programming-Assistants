-module(rotate_string).
-export([rotate_string/2]).

rotate_string(_, []) -> true;
rotate_string(S, G) ->
    case lists:member(G, generate_rotations(S)) of
        true -> true;
        false -> false
    end.

generate_rotations(S) ->
    generate_rotations(S, length(S), []).

generate_rotations(_, 0, Acc) ->
    Acc;
generate_rotations(S, N, Acc) ->
    Rotated = lists:sublist(S, N, length(S) - N + 1) ++ lists:sublist(S, N),
    generate_rotations(S, N - 1, [Rotated | Acc]).