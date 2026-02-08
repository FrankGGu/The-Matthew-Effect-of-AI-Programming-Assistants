-module(single_non_duplicate).
-export([single_non_duplicate/1]).

single_non_duplicate([H | T]) ->
    single_non_duplicate(H, T).

single_non_duplicate(Prev, [H | T]) ->
    if
        Prev == H ->
            single_non_duplicate(T);
        true ->
            Prev
    end;

single_non_duplicate(Prev, []) ->
    Prev.

single_non_duplicate([H | T]) ->
    single_non_duplicate(H, T).