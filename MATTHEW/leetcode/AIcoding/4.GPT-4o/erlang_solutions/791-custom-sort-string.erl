-module(solution).
-export([custom_sort_string/2]).

custom_sort_string(S, T) ->
    SortedT = lists:sort(fun(A, B) -> order(A, B, S) end, T),
    lists:map(fun(X) -> X end, SortedT).

order(A, B, S) ->
    case {position(A, S), position(B, S)} of
        {none, none} -> A < B;
        {none, _} -> false;
        {_, none} -> true;
        {PosA, PosB} -> PosA < PosB
    end.

position(X, S) ->
    case lists:position(X, S) of
        0 -> none;
        Pos -> Pos
    end.