-module(solution).
-export([make_good/1]).

make_good(S) ->
    make_good(S, []).

make_good([], Acc) -> 
    lists:reverse(Acc);
make_good([H | T], Acc) ->
    case Acc of
        [] -> make_good(T, [H | Acc]);
        [A | _] when abs(A - H) =:= 32 -> make_good(T, tl(Acc));
        _ -> make_good(T, [H | Acc])
    end.