-module(solution).
-export([make_great/1]).

make_great(Str) ->
    make_great(Str, []).

make_great([], Acc) ->
    lists:reverse(Acc);
make_great([H | T], Acc) ->
    case Acc of
        [] ->
            make_great(T, [H]);
        [A | _] when (H =:= A + 32) orelse (H + 32 =:= A) ->
            make_great(T, Acc);
        _ ->
            make_great(T, [H | Acc])
    end.