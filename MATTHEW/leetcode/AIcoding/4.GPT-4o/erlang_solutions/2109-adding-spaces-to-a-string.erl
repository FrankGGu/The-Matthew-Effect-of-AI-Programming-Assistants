-module(solution).
-export([add_spaces/2]).

add_spaces(S, indices) ->
    add_spaces(S, indices, 0, []).

add_spaces([], _, _, Acc) ->
    lists:reverse(Acc);
add_spaces(S, [I | Rest], Count, Acc) when Count =:= I ->
    add_spaces(tl(S), Rest, Count + 1, [hd(S), <<" ">> | Acc]);
add_spaces([H | T], Indices, Count, Acc) ->
    add_spaces(T, Indices, Count + 1, [H | Acc]).