-module(solution).
-export([canBeEqual/2]).

canBeEqual(S, T) ->
    canBeEqual(S, T, 0).

canBeEqual([], [], _) -> true;
canBeEqual([], _, _) -> false;
canBeEqual(_, [], _) -> false;
canBeEqual([H|T1], [H|T2], Count) ->
    canBeEqual(T1, T2, Count);
canBeEqual([H|T1], [N|T2], Count) when H =/= N ->
    case Count of
        0 -> canBeEqual(T1, T2, 1);
        _ -> false
    end.