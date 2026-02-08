-module(add_spaces).
-export([add_space/2]).

add_space(S, Spaces) ->
    add_space(S, Spaces, 0, []).

add_space([], _, _, Acc) ->
    lists:reverse(Acc);
add_space(S, [H | T], Index, Acc) ->
    if
        Index == H ->
            add_space(S, T, Index + 1, [$\s | Acc]);
        true ->
            add_space(S, [H | T], Index + 1, [hd(S) | Acc])
    end;
add_space(S, [], Index, Acc) ->
    add_space(S, [], Index + 1, [hd(S) | Acc]).